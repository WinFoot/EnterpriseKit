awk '{n=n+$7} END{print "High: " n}' result.txt
#High: 707
awk '{n=n+$8} END{print "Mid: " n}' result.txt
#Mid: 13987
awk '{n=n+$9} END{print "Low: " n}' result.txt
#Low: 6166
