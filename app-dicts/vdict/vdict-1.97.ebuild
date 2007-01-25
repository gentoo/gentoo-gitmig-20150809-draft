# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/vdict/vdict-1.97.ebuild,v 1.2 2007/01/25 04:54:29 genone Exp $

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
	elog "You may want to install app-dicts/vdict-* packages"
	elog "to have corresponding dictionaries"
}
