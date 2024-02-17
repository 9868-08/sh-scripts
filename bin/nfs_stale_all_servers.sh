#!/bin/bash
# Purpose:
# Detect Stale File handle and remove it
# Script created: July 29, 2015 by Birgit Ducarroz
# Last modification: 23.12.2020  /bdu
#

MYMAIL="my.mail@something.com"
THIS_HOST=`hostname`

# Detect Stale file handle and write output into a variable and then into a file
mounts=`df 2>&1 | grep 'Stale' |awk '{print ""$2"" }' > NFS_stales.txt`
sleep 8

# Remove : special characters from the output

sed -r -i 's/://' NFS_stales.txt && sed -r -i 's/‘//' NFS_stales.txt && sed -r -i 's/’//' NFS_stales.txt && sed -r -i 's/`//' NFS_stales.txt  && sed -r -i "s/'//" NFS_stales.txt 


# Not used: replace space by a new line
# stales=`cat NFS_stales.txt && sed -r -i ':a;N;$!ba;s/ /\n /g' NFS_stales.txt`

# read NFS_stales.txt output file line by line then unmount stale by stale.
#    IFS='' (or IFS=) prevents leading/trailing whitespace from being trimmed.
#    -r prevents backslash escapes from being interpreted.
#    || [[ -n $line ]] prevents the last line from being ignored if it doesn't end with a \n (since read returns a non-zero exit code when it encounters EOF).

while IFS='' read -r line || [[ -n "$line" ]]; do
    message=`echo "Unmounting due to NFS Stale file handle: $line"`
    echo echo | mail -s "$THIS_HOST: NFS Stale Handle unmounted" $MYMAIL <<< $message
    umount -f -l $line
done < "NFS_stales.txt"
mount -a

#EOF

