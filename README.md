# acd_verify
uses acd_cli and md5sum to verify remote files on acd automatically.

early beta. use at own risk.

# installation
requirements: acd_cli https://github.com/yadayada/acd_cli
```
git clone https://github.com/KOMsandFriends/acd_verify
cd acd_verify
sudo chmod +x acd_verify.sh
```

/var/log/acd_verify.log and /var/log/acd_verify_error.log have to be writeable for user:
```
# sudo touch /var/log/acd_verify.log
# sudo chown <YOUR USERNAME> /var/log/acd_verify.log

# sudo touch /var/log/acd_verify_error.log
# sudo chown <YOUR USERNAME> /var/log/acd_verify_error.log
```

# usage
It may be necessary to execute `acd_cli sync` before acd_verify.
`./acd_verify.sh LOCAL_FILE`
