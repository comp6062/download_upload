# download_upload
To automate the process of downloading a file file daily and uploading it to an FTP server on a Linux system


Here are the step-by-step instructions to install, set permissions, schedule the script in crontab, and manually run it:

---

### **1. Save the Script**
Save the script as `~/dowload_upload.sh`:
1. Open a terminal and run:
   ```bash
   nano ~/dowload_upload.sh
   ```
2. Paste the script content into the editor.
```bash
#!/bin/bash

# Constants
DOWNLOAD_URL="http://example.com/path_to_file"
LOCAL_FILE="/tmp/example.file"
FTP_SERVER="ftp.example.com"
FTP_USER="exampleuser@example.com"
FTP_PASSWORD="examplepassword"
REMOTE_DIRECTORY="/"
LOG_FILE="/tmp/~/dowload_upload_log.txt"

# Function to log messages with timestamp
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Start of script
echo "---------------------------------------------------------------------------------------------------------------------------" >> "$LOG_FILE"
log "Starting the script."

# Download the XML file
log "Starting the download from $DOWNLOAD_URL"
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
```
3. Save and exit by pressing `CTRL + O`, then `ENTER`, and `CTRL + X`.

---

### **2. Set Permissions**
Make the script executable:
```bash
chmod +x ~/dowload_upload.sh
```

---

### **3. Test the Script**
To manually run the script, use:
```bash
~/dowload_upload.sh
```

---

### **4. Schedule the Script with Cron**
1. Open the crontab editor:
   ```bash
   crontab -e
   ```
2. Add the following line to schedule the script to run at 12:00 AM, 6:00 AM, 12:00 PM, and 6:00 PM:
   ```bash
   0 0,6,12,18 * * * ~/dowload_upload.sh
   ```
   - `0` specifies the minute (start of the hour).
   - `0,6,12,18` specifies the hours (12 AM, 6 AM, 12 PM, and 6 PM).

3. Save and exit the crontab editor.

---

### **5. Verify Cron Jobs**
To confirm the crontab entry is saved, run:
```bash
crontab -l
```
You should see the line you added:
```bash
0 0,6,12,18 * * * ~/dowload_upload.sh
```

---

### **6. View Logs**
The script logs its activity to `/tmp/dowload_upload_log.txt`. Check the log for details:
```bash
cat /tmp/dowload_upload_log.txt
```

--- 

This setup ensures the script runs at the specified times and can also be executed manually when needed.
