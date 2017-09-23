chmod -R  a-w+r / || true
chmod -R  a+w /tmp || true
mkdir -p /home/tryjshell/.java
chown -R tryjshell:tryjshell /home/tryjshell/.java || true
chmod -R  a+w /home/tryjshell/.java || true
chmod -R  a+x /usr/bin/java || true
chmod -R  a+x /usr/bin/jshell || true