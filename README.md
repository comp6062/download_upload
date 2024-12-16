# download_upload
To automate the process of downloading a file file daily and uploading it to an FTP server on a Linux system


Here are the step-by-step instructions to install, set permissions, schedule the script in crontab, and manually run it:

---

### **1. Save the Script**
Save the script as `~/epg.sh`:
1. Open a terminal and run:
   ```bash
   nano ~/epg.sh
   ```
2. Paste the script content into the editor.
3. Save and exit by pressing `CTRL + O`, then `ENTER`, and `CTRL + X`.

---

### **2. Set Permissions**
Make the script executable:
```bash
chmod +x ~/epg.sh
```

---

### **3. Test the Script**
To manually run the script, use:
```bash
~/epg.sh
```

---

### **4. Schedule the Script with Cron**
1. Open the crontab editor:
   ```bash
   crontab -e
   ```
2. Add the following line to schedule the script to run at 12:00 AM, 6:00 AM, 12:00 PM, and 6:00 PM:
   ```bash
   0 0,6,12,18 * * * ~/epg.sh
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
0 0,6,12,18 * * * ~/epg.sh
```

---

### **6. View Logs**
The script logs its activity to `/tmp/epg_log.txt`. Check the log for details:
```bash
cat /tmp/epg_log.txt
```

--- 

This setup ensures the script runs at the specified times and can also be executed manually when needed.
