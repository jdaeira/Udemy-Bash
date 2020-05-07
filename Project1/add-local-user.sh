#!/bin/bash

# Get UID of user. Make sure it's the ROOT user

USER_ID=${UID}

if [[ ${USER_ID} -ne 0 ]]
then 
  echo "You must be ROOT to create a new user"
  exit 1
fi


# Ask for the user name
read -p 'Enter the username to create: ' USER_NAME

# Ask for the real name
read -p 'Enter the name of the person this account is for:  ' COMMENT

# Ask for the password
read -p 'Enter the password to use for the account: ' PASSWORD

# Create the user
sudo useradd -c "${COMMENT}" -m ${USER_NAME} 

# Check if the account was created successfully
if [[ "${?}" -ne 0 ]]
then
  echo 'There was an error creating the account!'
  exit 1
fi

# Set the password for the user
echo ${USER_NAME}:${PASSWORD} | chpasswd

# Check if the password was set
if [[ "${?}" -ne 0 ]]
then
  echo 'There was an error setting the password!'
  exit 1
fi

# Force password change on the first login
passwd -e ${USER_NAME}

# Display the created username
echo
echo "Username created is: ${USER_NAME}"

# Display the new users initial password
echo
echo "Initial password is: ${PASSWORD}"

# Display the hostname
echo
echo "Created on ${HOSTNAME}"

exit 0

