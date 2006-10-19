# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cheesetracker/cheesetracker-0.9.9-r1.ebuild,v 1.3 2006/10/19 22:53:58 weeve Exp $

inherit eutils

DESCRIPTION="A clone of Impulse Tracker with some extensions and a built-in sample editor; uses QT"
HOMEPAGE="http://cheesetronic.sf.net/"
SRC_URI="mirror://sourceforge/cheesetronic/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc sparc x86"
IUSE="jack"

RDEPEND="jack? ( media-sound/jack-audio-connection-kit )
	=dev-libs/libsigc++-1.2*
	=x11-libs/qt-3*"
DEPEND="${RDEPEND}
	>=dev-util/scons-0.94-r2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-64bit-clean.diff"
	epatch "${FILESDIR}/${P}-gcc4.patch"
	epatch "${FILESDIR}"/${P}-buffer-overflow.diff
}

src_compile() {
	scons || die
}

src_install() {
	dodir /usr/bin
	scons prefix=${D}/usr install || die
	dodoc AUTHORS ChangeLog NEWS README TODO docs/*.txt
}
