#!/bin/bash
# Variable for the report output file, choose an output file name
REPORT_FILE="data_output.txt"
# Output the hostname
echo "Gathering hostname..."
echo "==================== Hostname ====================" >> $REPORT_FILE
# Placeholder for command to get the hostname
host=$(hostname)
echo "Hostname: $host" >> $REPORT_FILE
printf "\n" >> $REPORT_FILE
echo "==================== OS Version ====================" >> $REPORT_FILE
printf "\n" >> $REPORT_FILE
# Output the OS version
echo "Gathering OS version..."
# Placeholder for command to get the OS version
os_name=$(grep '^NAME=' /etc/os-release | cut -d'=' -f2 | tr -d '"')
os_version=$(grep '^VERSION=' /etc/os-release | cut -d'=' -f2 | tr -d '"')
echo "==================== OS Version ====================" >> $REPORT_FILE
echo "OS Name: $os_name" >> $REPORT_FILE
echo "OS Version: $os_version" >> $REPORT_FILE
echo "" >> $REPORT_FILE
printf "\n" >> $REPORT_FILE
echo "==================== Memory ====================" >> $REPORT_FILE
printf "\n" >> $REPORT_FILE
# Output memory information
echo "Gathering memory information..."
# Placeholder for command to get memory info
memory=$(free -h)
echo "Memory Information: $memory" >> $REPORT_FILE
printf "\n" >> $REPORT_FILE
echo "==================== Uptime ====================" >> $REPORT_FILE
printf "\n" >> $REPORT_FILE
# Output uptime information
echo "Gathering uptime information..."
# Placeholder for command to get uptime info
up=$(uptime)
echo "Uptime Information: $up" >> $REPORT_FILE
printf "\n" >> $REPORT_FILE
echo "==================== OS Backup ====================" >> $REPORT_FILE
printf "\n" >> $REPORT_FILE

# Group research does not exist, adding a group here to get proper results for script
echo "Adding Research group"
addgroup="groupadd"
$addgroup research

# Backup the OS
echo "Backing up the OS..."
# Placeholder for command to back up the OS

if sudo tar -cvpzf /baker_street_backup.tar.gz --exclude=/baker_street_backup.tar.gz --exclude=/proc --exclude=/tmp --exclude=/mnt --exclude=/sys --exclude=/dev --exclude=/run /;

then

    echo "Backup completed successfully." >> $REPORT_FILE

else

    echo "Backup failed." >> $REPORT_FILE

fi

echo "" >> $REPORT_FILE
printf "\n" >> $REPORT_FILE
echo "==================== Sudoers File ====================" >> $REPORT_FILE
printf "\n" >> $REPORT_FILE
# Output the sudoers file to the report
echo "Gathering sudoers file..."
# Placeholder for command to output sudoers file
sudoers=$(cat /etc/sudoers 2>/dev/null)
echo "Sudoers file:$sudoers" >> $REPORT_FILE
printf "\n" >> $REPORT_FILE
echo "==================== World Permissions ====================" >> $REPORT_FILE
printf "\n" >> $REPORT_FILE
# Script to check for files with world permissions and update them
echo "Checking for files with world permissions..."
# Placeholder for command to find and update files with world permissions
world_perm="find /home -type f -perm -o=rwx 2> /dev/null -exec chmod 640 {} \;"
eval $world_perm
echo "World permissions have been removed from any files found." >> $REPORT_FILE
printf "\n" >> $REPORT_FILE
echo "==================== Listing the Found Scripts ====================" >> $REPORT_FILE
printf "\n" >> $REPORT_FILE
# Find specific files and update their permissions
echo "Updating permissions for specific scripts..."
echo "Found the Engineering, Research & Finance Script files below:" >> $REPORT_FILE
engineering_list="find / -type f \( -name \"*.sh\" -o -name \"*.py\" -o -name \"*.pl\" \) -iname \"*engineering*\" 2> /dev/null -exec ls -l {} \;"
eval "$engineering_list" >> $REPORT_FILE
research_list="find / -type f \( -name \"*.sh\" -o -name \"*.py\" -o -name \"*.pl\" \) -iname \"*research*\" 2> /dev/null -exec ls -l {} \;"
eval "$research_list" >> $REPORT_FILE
finance_list="find / -type f \( -name \"*.sh\" -o -name \"*.py\" -o -name \"*.pl\" \) -iname \"*finance*\" 2> /dev/null -exec ls -l {} \;"
eval "$finance_list" >> $REPORT_FILE
echo "==================== Updating Engineering Permissions ====================" >> $REPORT_FILE
printf "\n" >> $REPORT_FILE
# Engineering scripts - Only members of the engineering group
echo "Updating permissions for Engineering scripts."
# Placeholder for command to update permissions
engineering_perm="find / -type f \( -name \"*.sh\" -o -name \"*.py\" -o -name \"*.pl\" \) -iname \"*engineering*\" 2> /dev/null -exec chown :engineering {} +"
eval "$engineering_perm"
printf "\n" >> $REPORT_FILE
# List of updated files
echo "Permissions updated for Engineering scripts." >> $REPORT_FILE
printf "\n" >> $REPORT_FILE
eval "$engineering_list" >> $REPORT_FILE
printf "\n" >> $REPORT_FILE
echo "==================== Updating Research Permissions ====================" >> $REPORT_FILE
printf "\n" >> $REPORT_FILE
# Research scripts - Only members of the research group
echo "Updating permissions for Research scripts..."
# Placeholder for command to update permissions
research_perm="find / -type f \( -name \"*.sh\" -o -name \"*.py\" -o -name \"*.pl\" \) -iname \"*research*\" 2> /dev/null -exec chown :research {} +"
eval "$research_perm"
printf "\n" >> $REPORT_FILE
#List the updated files:
echo "Permissions updated for Research scripts" >> $REPORT_FILE
printf "\n" >> $REPORT_FILE
eval "$research_list" >> $REPORT_FILE
printf "\n" >> $REPORT_FILE
echo "==================== Updating Finance Permissions ====================" >> $REPORT_FILE
printf "\n" >> $REPORT_FILE
# Finance scripts - Only members of the finance group
echo "Updating permissions for Finance scripts"
# Placeholder for command to update permissions
finance_perm="find / -type f \( -name \"*.sh\" -o -name \"*.py\" -o -name \"*.pl\" \) -iname \"*finance*\" 2> /dev/null -exec chown :finance {} +"
eval "$finance_perm"
printf "\n" >> $REPORT_FILE
#List the updated files:
echo "Permissions updated for Finance scripts." >> $REPORT_FILE
printf "\n" >> $REPORT_FILE
eval "$finance_list" >> $REPORT_FILE
printf "\n" >> $REPORT_FILE
echo "==================== End  ====================" >> $REPORT_FILE
echo "Script execution completed. Check $REPORT_FILE for details."
echo "Script Complete" >> $REPORT_FILE