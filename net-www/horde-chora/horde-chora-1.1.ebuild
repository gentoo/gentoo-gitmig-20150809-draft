# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/horde-chora/horde-chora-1.1.ebuild,v 1.5 2003/09/06 01:54:08 msterret Exp $

DESCRIPTION="Chora is the Horde CVS viewer."
HOMEPAGE="http://www.horde.org"
P=chora-1.1
SRC_URI="ftp://ftp.horde.org/pub/chora/tarballs/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
DEPEND=""
RDEPEND=">=net-www/horde-2.1
	>=app-text/rcs-5.7-r1
	>=dev-util/cvs-1.11.2"
IUSE=""

find_http_root() {
	HTTPD_ROOT=`grep apache /etc/passwd | cut -d: -f6`/htdocs
	if [ -z "${HTTPD_ROOT}" ]; then
		eerror "HTTPD_ROOT is null! Using defaults."
		eerror "You probably want to check /etc/passwd"
		HTTPD_ROOT="/home/httpd/htdocs"
	fi

	REGISTRY=${HTTPD_ROOT}/horde/config/registry.php
	[ -f ${REGISTRY} ] || REGISTRY=${HTTPD_ROOT}/horde/config/registry.php.dist
}

src_compile() {
	echo "Nothing to compile"
}

src_install () {
	find_http_root

	# detecting apache usergroup
	GID=`grep apache /etc/group |cut -d: -f3`
	if [ -z "${GID}" ]; then
		einfo "Using default GID of 81 for Apache"
		GID=81
	fi

	dodir ${HTTPD_ROOT}/horde/chora
	cp -r . ${D}/${HTTPD_ROOT}/horde/chora

	# protecting files
	chown -R root.${GID} ${D}/${HTTPD_ROOT}/horde/chora
	find ${D}/${HTTPD_ROOT}/horde/chora/ -type f -exec chmod 0640 {} \;
	find ${D}/${HTTPD_ROOT}/horde/chora/ -type d -exec chmod 0750 {} \;
}

pkg_postinst() {
	find_http_root
	# add module in horde
	sed -e "/^\/\/.*\(\$this->applications\['chora'\].*\)/ \
		{ : next ; N ; /\;/ { s/\/\///g ; b } ; b next }" \
		< ${REGISTRY} > ${REGISTRY}.temp
	cp ${REGISTRY}.temp ${REGISTRY}
	rm ${REGISTRY}.temp

	einfo "Please read ${HTTPD_ROOT}/horde/chora/docs/INSTALL !"
}

pkg_prerm() {
	find_http_root
	# rm module from horde
	sed -e "/\(\$this->applications\['chora'\].*\)/ \
		{ s/\(.*\)/\/\/\1/g; : suite ; N ; /\;/ { s/\n/\n\/\//g ; b } ; \
		b suite }" \
		< ${REGISTRY} > ${REGISTRY}.temp
	cp ${REGISTRY}.temp ${REGISTRY}
	rm ${REGISTRY}.temp
}
