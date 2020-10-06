FROM osixia/openldap-backup:1.4.0

LABEL maintainer="tobiasbp@gmail.com"

ENV FD_RELEASE=1.3 \
    FD_ADMIN_PASSWORD=admin \
    BOOTSTRAP_DIR=/container/service/slapd/assets/config/bootstrap

# Add the FD schemas and the fd-config.ldif
COPY image/fd-${FD_RELEASE}/bootstrap  ${BOOTSTRAP_DIR}

# Install mkpassword (in whois) so we can encrypt admin's password
RUN apt-get -y update && LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y whois && \ 
    # Delete "Mandriva Management Console" schemas from base image (Some are also in FD)
    rm -rf ${BOOTSTRAP_DIR}/schema/mmc && \
    # remove this schema, because it's in the base image (But I like to keep it in this repo for completeness)
    rm -rf ${BOOTSTRAP_DIR}/schema/fd-core/rfc2307bis.schema && \
    # Encrypt admin password
    export FD_ADMIN_PASSWORD_ENCRYPTED=`echo "${FD_ADMIN_PASSWORD}" | mkpasswd -m sha512crypt --stdin` && \
    # Encrypt admins password
    echo ${FD_ADMIN_PASSWORD_ENCRYPTED} && \
    # Add encrypted admin password in ldif
    sed -i "s|{{ FD_ADMIN_PASSWORD }}|\{crypt\}${FD_ADMIN_PASSWORD_ENCRYPTED}|g" ${BOOTSTRAP_DIR}/ldif/fd-config.ldif && \
    # Set org name (Env from base image)
    sed -i "s|{{ LDAP_ORGANIZATION }}|${LDAP_ORGANIZATION}|g" ${BOOTSTRAP_DIR}/ldif/fd-config.ldif

