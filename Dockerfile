FROM osixia/openldap-backup:1.4.0
LABEL maintainer="tobiasbp@gmail.com"

# Remove this dir with schema files, so they don't conflict with user's futire import
RUN rm -rf /container/service/slapd/assets/config/bootstrap/schema/mmc


