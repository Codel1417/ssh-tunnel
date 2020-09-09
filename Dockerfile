FROM alpine:latest

ENV SSH_USERNAME=null
ENV SSH_REMOTE_IP=null
ENV SSH_REMOTE_PORT=22
ENV SSH_LOCAL_IP=null
ENV SSH_BASE64_KEY=null;

# Install requirements for add-on
RUN apk add --no-cache openssh coreutils bash

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh
    
CMD [ "/run.sh" ]