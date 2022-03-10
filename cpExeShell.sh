#!/usr/bin/expect -f
set HOST [lindex $argv 0]
set USER [lindex $argv 1]
set PASSWD [lindex $argv 2]
set TMPDIR [lindex $argv 3]
set DSTDIR [lindex $argv 4]
set FILENM [lindex $argv 5]

set timeout -1
spawn sftp -P 22 $USER@$HOST:$DSTDIR
expect {
 "(yes/no)?" {
   send "yes\n"
   expect "*assword:" { send "$PASSWD\n"}
  }
  "*assword:" {
   send "$PASSWD\n"
  }
}
expect "sftp>"
send "put -r $TMPDIR"
expect "sftp>"
send "bye\r"
expect eof
