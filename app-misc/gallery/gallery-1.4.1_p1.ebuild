# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gallery/gallery-1.4.1_p1.ebuild,v 1.1 2004/01/25 18:46:47 mholzer Exp $

inherit webapp-apache

MY_P=${P/_p/-pl}
DESCRIPTION="Web based (PHP Script) photo album viewer/creator."
HOMEPAGE="http://gallery.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 ppc sparc alpha mips hppa amd64"
DEPEND=">=net-www/apache-1.3.24-r1
	>=dev-php/mod_php-4.1.2-r5
	>=media-gfx/jhead-1.6
	>=media-libs/netpbm-9.12
	>=media-gfx/imagemagick-5.4.9.1-r1"

S=${WORKDIR}/${PN}

webapp-detect || NO_WEBSERVER=1

pkg_setup() {
	webapp-pkg_setup "${NO_WEBSERVER}"
	einfo "Installing into ${ROOT}${HTTPD_ROOT}."
}

src_install() {
	webapp-mkdirs

	local DocumentRoot=${HTTPD_ROOT}
	local destdir=${DocumentRoot}/${PN}
	dodir ${destdir}
	dodoc AUTHORS ChangeLog README LICENSE.txt
	rm -rf ChangeLog

	cp -r . ${D}/${HTTPD_ROOT}/${PN}
	cd ${D}/${HTTPD_ROOT}
	chown -R ${HTTPD_USER}:${HTTPD_GROUP} ${PN}
	# Fix permissions
	find ${D}${destdir} -type d | xargs chmod 755
	find ${D}${destdir} -type f | xargs chmod 644

	#dohtml docs/*
}

pkg_postinst() {
	local DocumentRoot=${HTTPD_ROOT}
	local destdir=${DocumentRoot}/${PN}
#	chown -R apache:apache ${DST_PATH}
	chown root:root ${destdir}/secure.sh ${destdir}/configure.sh
	chmod 700 ${destdir}/secure.sh ${destdir}/configure.sh

	einfo
	einfo "For new installations point your browser to "
	einfo "http://www.yourhost.com/gallery/setup/"
	einfo "and follow the instructions."
	einfo "--------------------------------------------"
	einfo "For upgrades, just run"
	einfo "# cd ${destdir}"
	einfo "# sh ./secure.sh"
	einfo
}
