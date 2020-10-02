FROM osixia/openldap-backup

LABEL maintainer="tobiasbp@gmail.com"

# Delete "Mandriva Management Console" schemas from base image (Some are also in FD)
RUN rm -rfv /container/service/slapd/assets/config/bootstrap/schema/mmc

# Add the FD schemas
COPY src/bootstrap /container/service/slapd/assets/config/bootstrap
