# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/horde-chora/horde-chora-1.2-r1.ebuild,v 1.4 2003/10/18 18:54:59 mholzer Exp $

DESCRIPTION="Chora ${PV} is the Horde CVS viewer."
HOMEPAGE="http://www.horde.org"
MY_P=${P/horde-/}
SRC_URI="ftp://ftp.horde.org/pub/chora/tarballs/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
DEPEND=""
RDEPEND=">=net-www/horde-2.2.1
	>=app-text/rcs-5.7-r1
	>=dev-util/cvs-1.11.2"
IUSE=""
S=${WORKDIR}/${MY_P}

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

src_install () {
	find_http_root

	# detecting apache usergroup
	GID=`grep apache /etc/group |cut -d: -f3`
	if [ -z "${GID}" ]; then
		einfo "Using default GID of 81 for Apache"
		GID=81
	fi

	dodoc COPYING README docs/*
	rm -rf COPYING README docs
	dodir ${HTTPD_ROOT}/horde/chora
	cp -r . ${D}/${HTTPD_ROOT}/horde/chora

	# protecting files
	chown -R root.${GID} ${D}/${HTTPD_ROOT}/horde/chora
	find ${D}/${HTTPD_ROOT}/horde/chora/ -type f -exec chmod 0640 {} \;
	find ${D}/${HTTPD_ROOT}/horde/chora/ -type d -exec chmod 0750 {} \;
}
pkg_postinst() {
	find_http_root
	einfo "Please read ${HTTPD_ROOT}/horde/chora/docs/INSTALL !"
}
