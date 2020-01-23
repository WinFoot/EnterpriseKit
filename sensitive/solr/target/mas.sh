#masscan -p 80 --rate=10000 210.0.0.0/8 -oL 80.log
#masscan -p 8983 --rate=10000 210.0.0.0/8 -oL 8983.log
nohup masscan -p 8080 --rate=10000 210.0.0.0/8 -oL 8080.log &
