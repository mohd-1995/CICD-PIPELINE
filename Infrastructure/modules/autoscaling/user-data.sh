#!/bin/bash

# Update the operating system and install Docker
sudo yum update -y
sudo yum install -y docker

# Install cronie (provides cron and crontab)
sudo yum install -y cronie


# Start the Docker service
sudo systemctl start docker

# Ensure the Docker service starts on boot
sudo systemctl enable docker

# Add the ec2-user to the Docker group
sudo usermod -a -G docker ec2-user

# Adjust permissions on the Docker socket
sudo chmod 666 /var/run/docker.sock

# Wait for the Docker daemon to be active
while ! docker info > /dev/null 2>&1; do
   sleep 1
done

# Create the update script in /tmp
cat <<'EOF' > /tmp/update_docker_image.sh
#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# Stop the currently running container
docker stop my-container

# Remove the stopped container
docker rm my-container

# Pull the latest Docker image
docker pull mohd1995/cicd-pipeline:latest

# Run the Docker container with the latest image
docker run -d --name my-container -p 80:80 mohd1995/cicd-pipeline:latest
EOF

# Ensure the script is executable
sudo chmod +x /tmp/update_docker_image.sh

# Ensure the cron service starts on boot and is running
sudo systemctl enable crond
sudo systemctl start crond

# Add a cron job to run the script everyday at midnight
( crontab -l 2>/dev/null; echo "0 0 * * * /bin/bash /tmp/update_docker_image.sh >> /var/log/update_docker_image.log 2>&1" ) | crontab -


# Start the initial Docker container manually
/tmp/update_docker_image.sh


# Attempt to update the Docker image
if /tmp/update_docker_image.sh; then


# Publish success message to SNS topic
  aws sns publish --topic-arn arn:aws:sns:eu-west-2:768983712348:docker-pull-notification --message "Docker image pull completed successfully on $(date)."
else
  # Publish failure message to SNS topic
  aws sns publish --topic-arn arn:aws:sns:eu-west-2:768983712348:docker-pull-notification --message "Docker image pull FAILED on $(date)."
fi   
  