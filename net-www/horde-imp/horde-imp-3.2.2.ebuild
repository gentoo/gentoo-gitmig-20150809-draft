# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/horde-imp/horde-imp-3.2.2.ebuild,v 1.6 2003/12/15 20:53:08 stuart Exp $

inherit webapp-apache

DESCRIPTION="Horde IMP provides webmail access"
HOMEPAGE="http://www.horde.org"
MY_P=${P/horde-/}
SRC_URI="ftp://ftp.horde.org/pub/imp/tarballs/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
DEPEND=""
RDEPEND=">=net-www/horde-2.2.4"
S=${WORKDIR}/${MY_P}

webapp-detect || NO_WEBSERVER=1

pkg_setup() {
	# FIXME: Is this really how we want to do this ?
	GREP=`grep imap /var/db/pkg/dev-php/mod_php*/USE`
	if [ "${GREP}" != "" ]; then
		return 0
	else
		eerror "Missing IMAP support in mod_php !"
		die "aborting..."
	fi
	webapp-pkg_setup "${NO_WEBSERVER}"
	einfo "Installing into ${ROOT}${HTTPD_ROOT}."
}

src_install () {
	webapp-mkdirs

	local DocumentRoot=${HTTPD_ROOT}
	local destdir=${DocumentRoot}/horde/imp

	dodoc COPYING README docs/*
	rm -rf COPYING README docs

	dodir ${destdir}
	cp -r . ${D}${destdir}
	cd ${D}/${HTTPD_ROOT}/horde

	# protecting files
	chown -R ${HTTPD_USER}:${HTTPD_GROUP} imp
	find ${D}/${destdir} -type f -exec chmod 0640 {} \;
	find ${D}/${destdir} -type d -exec chmod 0750 {} \;
}

pkg_postinst() {
	einfo "Please read /usr/share/doc/${PF}/INSTALL.gz !"
}
