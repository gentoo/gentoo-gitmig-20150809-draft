# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/horde-imp/horde-imp-3.1.ebuild,v 1.6 2003/09/11 19:13:37 mholzer Exp $

DESCRIPTION="IMP provides webmail access"
HOMEPAGE="http://www.horde.org"
MY_P=${P/horde-/}
SRC_URI="ftp://ftp.horde.org/pub/imp/tarballs/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
DEPEND=""
RDEPEND=">=net-www/horde-2.1"
S=${WORKDIR}/${MY_P}

find_http_root() {
	export HTTPD_ROOT=`grep apache /etc/passwd | cut -d: -f6`/htdocs

	if [ -z "${HTTPD_ROOT}" ]; then
		eerror "HTTPD_ROOT is null! Using defaults."
		eerror "You probably want to check /etc/passwd"
		HTTPD_ROOT="/home/httpd/htdocs"
	fi

	export REGISTRY=${HTTPD_ROOT}/horde/config/registry.php
	[ -f ${REGISTRY} ] || REGISTRY=${HTTPD_ROOT}/horde/config/registry.php.dist
}

pkg_setup() {
	# FIXME: Is this really how we want to do this ?
	GREP=`grep imap /var/db/pkg/dev-php/mod_php*/USE`
	if [ "${GREP}" != "" ]; then
		return 0
	else
		eerror "Missing IMAP support in mod_php !"
		die "aborting..."
	fi
	find_http_root
	[ -f ${REGISTRY} ] || die "${REGISTRY} not found"
}

src_compile() {
	 echo "Nothing to compile"
}

src_install () {

	# detecting apache usergroup
	# FIXME: With time, apache's GID should be static
	GID=`grep apache /etc/group |cut -d: -f3`
	if [ -z "${GID}" ]; then
		einfo "Using default GID of 81 for Apache"
		GID=81
	fi

	find_http_root

	dodir ${HTTPD_ROOT}/horde/imp
	cp -r . ${D}/${HTTPD_ROOT}/horde/imp

	# protecting files
	chown -R root.${GID} ${D}/${HTTPD_ROOT}/horde/imp
	find ${D}/${HTTPD_ROOT}/horde/imp/ -type f -exec chmod 0640 {} \;
	find ${D}/${HTTPD_ROOT}/horde/imp/ -type d -exec chmod 0750 {} \;
}

pkg_postinst() {

	find_http_root

	# add module in horde
	sed -e "/^\/\/.*\(\$this->applications\['imp'\].*\)/ \
		{ : next ; N ; /\;/ { s/\/\///g ; b } ; b next }" \
		< ${REGISTRY} > ${REGISTRY}.temp
	cp ${REGISTRY}.temp ${REGISTRY}
	rm ${REGISTRY}.temp

	# end
	einfo "Please read ${HTTPD_ROOT}/horde/imp/docs/INSTALL !"
}

pkg_prerm() {
	find_http_root

	# rm module from horde
	sed -e "/\(\$this->applications\['imp'\].*\)/ \
		{ s/\(.*\)/\/\/\1/g; : suite ; N ; /\;/ { s/\n/\n\/\//g ; b } ; \
		b suite }" \
		< ${REGISTRY} > ${REGISTRY}.temp
	cp ${REGISTRY}.temp ${REGISTRY}
	rm ${REGISTRY}.temp
}
