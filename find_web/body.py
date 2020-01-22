import os

counters = {}
fs = os.listdir('dbs')
for f1 in fs:
    if 'body' in f1:
        #print f1
        fr=open("dbs/"+f1,"r")
        tx=fr.readlines()
        tx=' '.join(tx)
        items = tx.split(' ')
        for item in items:
            if item in counters:
                counters[item] += 1
            else:
                counters[item] = 1

#print "Count of different word:"
#print counters
#print "Most popular word:"
#print sorted([(counter,word) for word,counter in counters.items()],reverse=True)[0][1]
values = sorted([(counter,word) for word,counter in counters.items()],reverse=False)
for key,value in values:
    print key
    print value
