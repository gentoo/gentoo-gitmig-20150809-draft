# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gdeskcal/gdeskcal-0.57.1-r1.ebuild,v 1.5 2005/08/13 23:25:40 hansmi Exp $

inherit eutils

DESCRIPTION="Cute little eye-candy calendar for the desktop"
HOMEPAGE="http://www.pycage.de/software_gdeskcal.html"

# The name of the source tarball differs slightly from the package
# name and version:
MY_PN=gDeskCal
MY_P=${MY_PN}-${PV//./_}
SRC_URI="http://www.pycage.de/download/${MY_P}.tar.gz"

# The name of the unpacked tarball's sourcedir isn't the default $S
S="${WORKDIR}/${MY_PN}-${PV}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ppc64 x86"

IUSE="gnome"

DEPEND=">=dev-lang/python-2.0
	>=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	>=dev-python/pygtk-2.0"

src_unpack() {
	unpack ${A}
	# Session support for gDeskCal (requires pygtk[gnome])
	use gnome && epatch ${FILESDIR}/${P}-gnomeui.patch

	epatch ${FILESDIR}/${PN}-evo2.patch
}

src_install() {
	# put documents in the right place
	dodoc AUTHORS NEWS README README.i18n README.skins

	# gdeskcal Python objects and i18n files
	GDESKCAL_DIR=/usr/share/${PN}
	dodir ${GDESKCAL_DIR}
	cp -R code skins data locale po gdeskcal ${D}${GDESKCAL_DIR}
	# make a symlink from /usr/share/gdeskcal/gdeskcal to /usr/bin/gdeskcal
	dodir /usr/bin
	dosym ${GDESKCAL_DIR}/gdeskcal /usr/bin/gdeskcal
}

pkg_postinst() {
	# some useful information about where to get skins
	einfo
	einfo "Skins for gDeskCal can be found at:"
	einfo "  ${HOMEPAGE}"
	einfo
	einfo "To install a new skin simply drag it onto the gDeskCal skinbrowser"
	einfo
}
