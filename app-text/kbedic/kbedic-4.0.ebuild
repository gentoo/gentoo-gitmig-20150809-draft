# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kbedic/kbedic-4.0.ebuild,v 1.12 2006/08/20 19:57:27 malc Exp $

inherit kde eutils

DESCRIPTION="English <-> Bulgarian Dictionary"
HOMEPAGE="http://kbedic.sourceforge.net"
SRC_URI="mirror://sourceforge/kbedic/$P.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"
IUSE="kde"

DEPEND="=x11-libs/qt-3*
	kde? ( >=kde-base/kdelibs-3 )"


src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/ppc-gfxopt.patch
}

src_compile() {
	set-qtdir 3
	set-kdedir 3

	myconf="--prefix=/usr"
	use kde && myconf="$myconf --with-kde"
	use kde && kde_src_compile myconf
	kde_src_compile configure make
}

src_install() {
	kde_src_install
	if use kde; then
		insinto /usr/share/applnk/Utilities/kbedic.desktop
		doins ${FILESDIR}/kbedic.desktop
	fi
}
