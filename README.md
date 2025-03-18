So you don't have to go to the servers yourself and check when to clean them. The script will send a message to Telegram when the volume exceeds the threshold. 
Give execution permissions and add to crontab

`chmod +x hdd_monitor.sh`

`crontab -e`
0 5 * * * /home/sprofi/hdd_monitor.sh
