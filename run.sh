#!/usr/bin/env bash
set -e

#install key
mkdir ~/.ssh || true
echo -n $SSH_BASE64_KEY | base64 -di | grep -v "Base64" | tee ~/.ssh/id_rsa > /dev/null
#strip base64 errors

chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa

#register key
eval `ssh-agent`
ssh-add ~/.ssh/id_rsa

set -x # activate debugging from here

ssh -v -o StrictHostKeyChecking=no -o ExitOnForwardFailure=yes -N -T -p $SSH_REMOTE_PORT -R 443:$SSH_LOCAL_IP:443 -R 80:$SSH_LOCAL_IP:80  $SSH_USERNAME@$SSH_REMOTE_IP
echo "Sleeping for 30 seconds"
sleep 30 # wait 30 seconds before reconnecting