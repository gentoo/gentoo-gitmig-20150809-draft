# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gdeskcal/gdeskcal-0.57.1.ebuild,v 1.1 2004/07/18 07:07:17 pclouds Exp $

DESCRIPTION="Cute little eye-candy calendar for the desktop"
HOMEPAGE="http://www.pycage.de/software_gdeskcal.html"

# The name of the source tarball differs slightly from the package
# name and version:
MY_P="`echo ${P} | tr .dc _DC`"
SRC_URI="http://www.pycage.de/download/${MY_P}.tar.gz"

# The name of the unpacked tarball's sourcedir isn't the default $S
S="${WORKDIR}/`echo $MY_P | tr _ .`"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

IUSE=""

RDEPEND=">=dev-lang/python-2.0
	>=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	>=dev-python/pygtk-2.0"

GDESKCAL_DIR=/usr/share/${PN}

src_install() {
	# put documents in the right place
	dodoc AUTHORS NEWS README README.i18n README.skins

	# gdeskcal Python objects and i18n files
	dodir ${GDESKCAL_DIR}
	cp -R code skins data locale po gdeskcal ${D}${GDESKCAL_DIR}
	# make a symlink from /usr/share/gdeskcal/gdeskcal to /usr/bin/gdeskcal
	dodir /usr/bin
	dosym ${GDESKCAL_DIR}/gdeskcal /usr/bin/gdeskcal
}

pkg_postinst() {
	# some useful information about where to get skins
	einfo ""
	einfo "Skins for gDeskCal can be found at:"
	einfo "  ${HOMEPAGE}"
	einfo ""
	einfo "To install a new skin simply drag it onto the gDeskCal skinbrowser"
	einfo ""
}
