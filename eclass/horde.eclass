# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/horde.eclass,v 1.1 2004/01/27 00:51:38 vapier Exp $
#
# Author: vapier@gentoo.org
# Help manage the horde project http://www.horde.org/

inherit webapp-apache

ECLASS=horde
INHERITED="$INHERITED $ECLASS"

EXPORT_FUNCTIONS pkg_setup src_install pkg_postinst

[ -z "${HORDE_PN}" ] && HORDE_PN="${PN/horde-}"
HOMEPAGE="http://www.horde.org/${HORDE_PN}"
SRC_URI="http://ftp.horde.org/pub/${HORDE_PN}/tarballs/${HORDE_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

S=${WORKDIR}/${HORDE_PN}-${PV}

horde_pkg_setup() {
	webapp-detect || NO_WEBSERVER=1
	webapp-pkg_setup "${NO_WEBSERVER}"
}

horde_src_install() {
	webapp-mkdirs

	local DocumentRoot=${HTTPD_ROOT}
	local destdir=${DocumentRoot}/horde
	[ "${HORDE_PN}" != "horde" ] && destdir=${destdir}/${HORDE_PN}

	dodoc README docs/*
	rm -rf COPYING LICENSE README docs

	dodir ${destdir}
	cp -r . ${D}/${destdir}/
	cd ${D}/${destdir}

	# protecting files
	chown -R ${HTTPD_USER}:${HTTPD_GROUP} ${D}/${destdir}
	find ${D}/${destdir} -type f -exec chmod 0640 '{}' \;
	find ${D}/${destdir} -type d -exec chmod 0750 '{}' \;
}

horde_pkg_postinst() {
	einfo "Please read /usr/share/doc/${PF}/INSTALL.gz"
	einfo "Before this package will work you have to setup"
	einfo "the configuration files.  Please review the"
	einfo "config/ subdirectory of ${HORDE_PN} in the webroot."
}
