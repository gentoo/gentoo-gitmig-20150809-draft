# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/vdict/vdict-1.97.ebuild,v 1.1 2005/12/03 10:29:16 pclouds Exp $

inherit eutils

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
DESCRIPTION="Vdict - Vietnamese Dictionary"
SRC_URI="http://xvnkb.sourceforge.net/vdict/${P}.tar.bz2
	mirror://gentoo/${PN}-patches-${PV}.tar.bz2"
#	http://dev.gentoo.org/~pclouds/${PN}-patches-${PV}.tar.bz2"
HOMEPAGE="http://xvnkb.sourceforge.net/?menu=vdict&lang=en"
IUSE=""
DEPEND="x11-libs/qt
	sys-libs/gdbm
	media-libs/freetype"

src_install() {
	dobin fd/fd vd/vd utils/wd2vd
}

pkg_postinst() {
	einfo "You may want to install app-dicts/vdict-* packages"
	einfo "to have corresponding dictionaries"
}
