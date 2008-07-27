# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/vdict/vdict-1.94.ebuild,v 1.6 2008/07/27 19:15:32 carlo Exp $

EAPI=1
inherit eutils qt3

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
DESCRIPTION="Vdict - Vietnamese Dictionary"
SRC_URI="mirror://sourceforge/xvnkb/${P}.tar.bz2"
HOMEPAGE="http://xvnkb.sourceforge.net/?menu=vdict&lang=en"
IUSE=""
DEPEND="x11-libs/qt:3
	sys-libs/gdbm
	media-libs/freetype"

src_install() {
	dobin fd/fd vd/vd utils/wd2vd
}

pkg_postinst() {
	elog "You may want to install app-dicts/vdict-* packages"
	elog "to have corresponding dictionaries"
}
