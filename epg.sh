#!/bin/bash

# Constants
DOWNLOAD_URL="http://tv.youriptv.xyz/xmltv.php?username=A051611&password=DJ1C4NC"
LOCAL_FILE="/tmp/EPG.xml"
FTP_SERVER="ftp.kdowns.xyz"
FTP_USER="xml@youriptv.xyz"
FTP_PASSWORD="Alex51611"
REMOTE_DIRECTORY="/"
LOG_FILE="/tmp/epg_log.txt"

# Function to log messages with timestamp
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Start of script
echo "---------------------------------------------------------------------------------------------------------------------------" >> "$LOG_FILE"
log "Starting the script."

# Download the XML file
log "Downloading EPG from $DOWNLOAD_URL"
wget -O "$LOCAL_FILE" "$DOWNLOAD_URL"

# Check if the file was downloaded successfully
if [ -f "$LOCAL_FILE" ]; then
    log "File downloaded successfully: $LOCAL_FILE"
    
    # Upload the file to the FTP server
    log "Starting upload of $LOCAL_FILE to FTP server $FTP_SERVER"
    curl --insecure -T "$LOCAL_FILE" --user "$FTP_USER:$FTP_PASSWORD" "ftp://$FTP_SERVER$REMOTE_DIRECTORY"
    
    # Check if the upload was successful
    if [ $? -eq 0 ]; then
        log "File uploaded successfully."
    else
        log "File upload failed."
    fi

    # Clean up the local file
    rm "$LOCAL_FILE"
    if [ $? -eq 0 ]; then
        log "Local file cleaned up successfully: $LOCAL_FILE"
    else
        log "Failed to clean up local file: $LOCAL_FILE"
    fi

    log "Script completed."
else
    log "File download failed."
    log "Script failed."
fi
