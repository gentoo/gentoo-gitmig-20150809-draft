# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kbedic/kbedic-4.0.ebuild,v 1.16 2009/08/07 09:02:38 ssuominen Exp $

ARTS_REQUIRED="never"

inherit kde eutils

DESCRIPTION="English <-> Bulgarian Dictionary"
HOMEPAGE="http://kbedic.sourceforge.net"
SRC_URI="mirror://sourceforge/kbedic/$P.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="kde"

DEPEND="=x11-libs/qt-3*
	kde? ( =kde-base/kdelibs-3* )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-dont-filter-cflags.patch \
		"${FILESDIR}"/${P}-gcc44.patch
	eautoreconf
}

src_compile() {
	set-qtdir 3
	set-kdedir 3

	myconf="--prefix=/usr"
	use kde && myconf="$myconf --with-kde"
	use kde && kde_src_compile myconf
	kde_src_compile configure make
}
