# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/horde/horde-2.2.4.ebuild,v 1.11 2004/01/07 21:41:15 robbat2 Exp $

inherit webapp-apache

S=${WORKDIR}/${P}

DESCRIPTION="Horde Application Framework"
HOMEPAGE="http://www.horde.org"
SRC_URI="http://ftp.horde.org/pub/horde/tarballs/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
DEPEND=""
RDEPEND=">=dev-php/mod_php-4.1.0
	>=sys-devel/gettext-0.10.40
	>=dev-libs/libxml2-2.4.21
	>=net-www/horde-pear-1.1"
IUSE=""

webapp-detect || NO_WEBSERVER=1

pkg_setup() {
	if [ -L ${HTTPD_ROOT}/horde ] ; then
		ewarn "You need to unmerge your old Horde version first."
		ewarn "Horde will be installed into ${HTTPD_ROOT}/horde"
		ewarn "directly instead of a version-dependant directory."
		die "need to unmerge old version first"
	fi
	webapp-pkg_setup "${NO_WEBSERVER}"
	einfo "Installing into ${ROOT}${HTTPD_ROOT}."
}

src_install () {
	webapp-mkdirs

	local DocumentRoot=${HTTPD_ROOT}
	local destdir=${DocumentRoot}/${PN}

	dodoc COPYING README docs/*
	rm -rf COPYING README docs

	dodir ${destdir}
	cp -r . ${D}${destdir}

	cd ${D}/${HTTPD_ROOT}
	chown -R ${HTTPD_USER}:${HTTPD_GROUP} ${PN}

	# Fix permissions
	find ${D}/${HTTPD_ROOT}/horde/ -type f -exec chmod 0640 {} \;
	find ${D}/${HTTPD_ROOT}/horde/ -type d -exec chmod 0750 {} \;
	chmod 0000 ${D}${destdir}/test.php
}

pkg_postinst() {
	einfo "Horde requires PHP to have :"
	einfo "    ==> 'short_open_tag enabled = On'"
	einfo "    ==> 'magic_quotes_runtime set = Off'"
	einfo "    ==> 'file_uploads enabled = On'"
	einfo "Please edit /etc/php4/php.ini."
	einfo ""
	einfo "Please read /usr/share/doc/${PF}/INSTALL.gz !"
}
