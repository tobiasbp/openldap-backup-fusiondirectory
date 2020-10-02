FROM osixia/openldap-backup:1.4.0

LABEL maintainer="tobiasbp@gmail.com"

ENV FD_RELEASE=1.3.1

# Add the FD schemas
COPY src/bootstrap-fd-${FD_RELEASE} /container/service/slapd/assets/config/bootstrap

# Delete "Mandriva Management Console" schemas from base image (Some are also in FD)
RUN rm -rf /container/service/slapd/assets/config/bootstrap/schema/mmc && \
    # remove this schema, because it's in the base image (But I like to keep it in this repo for completeness)
    rm -rf /container/service/slapd/assets/config/bootstrap/schema/fd-core/rfc2307bis.schema
