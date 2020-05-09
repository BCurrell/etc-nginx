#!/bin/bash

###
###

if [[ "${#}" != 1 ]]
then
	>&2 echo "Usage: ${0} <nginx-site>"
	exit 1
fi

SITE="${1}"

if [[ ! -f "/etc/nginx/sites-available/${SITE}" ]]
then
	>&2 echo "Unknown site, missing nginx config: ${SITE}"
	exit 2
fi

WEBROOT="/var/www/${SITE}"

if [[ ! -d "${WEBROOT}" ]]
then
	>&2 echo "Unknown site, missing web root: ${SITE}"
	exit 3
fi

if [[ ! -f "/etc/nginx/sites-enabled/${SITE}" ]]
then
	>&2 echo "Inactive site, continuing cert generation: ${SITE}"
fi

mkdir -p "${WEBROOT}/ssl"

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout "${WEBROOT}/ssl/${SITE}.key" -out "${WEBROOT}/ssl/${SITE}.crt"
