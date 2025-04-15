#!/bin/bash

# Variable for the report output file, choose a NEW output file name
REPORT_FILE="hardening2.txt"

# Output the sshd configuration file
echo "Gathering details from sshd configuration file"

echo "==================== SSHD Config File ====================" >> $REPORT_FILE

# Get the sshd configuration file
sshd_config=$(cat /etc/ssh/sshd_config)
echo "sshd configuration file: $sshd_config" >> $REPORT_FILE

printf "\n" >> $REPORT_FILE

# Packages & Services section
echo "==================== Packages & Services ====================" >> $REPORT_FILE

# Update packages and services
echo "Updating packages and services"
update="apt update -y"
eval "$update"

# Upgrade packages
upgrade="apt upgrade -y"
eval "$upgrade"

echo "Packages have been updated and upgraded" >> $REPORT_FILE

printf "\n" >> $REPORT_FILE

# Package List section
echo "==================== Package List ====================" >> $REPORT_FILE

# List all installed packages
pack_list="apt list --installed"
installed_packages=$(eval "$pack_list")
echo "Installed Packages: $installed_packages" >> $REPORT_FILE

printf "\n" >> $REPORT_FILE

# Journald Config File section
echo "==================== Journald Config File ====================" >> $REPORT_FILE

# Display journald configuration data
echo "Printing out logging configuration data"
journal=$(cat /etc/systemd/journald.conf)
echo "journald.conf file data: $journal" >> $REPORT_FILE

printf "\n" >> $REPORT_FILE

# Log Rotate Config File section
echo "==================== Log Rotate Config File ====================" >> $REPORT_FILE

# Display logrotate configuration data
logrotate=$(cat /etc/logrotate.conf)
echo "logrotate.conf file data: $logrotate" >> $REPORT_FILE

printf "\n" >> $REPORT_FILE

# End of Script
echo "==================== End Of Script ====================" >> $REPORT_FILE

echo "Script execution completed. Check $REPORT_FILE for details."
