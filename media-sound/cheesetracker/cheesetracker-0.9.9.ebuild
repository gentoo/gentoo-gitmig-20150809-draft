# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cheesetracker/cheesetracker-0.9.9.ebuild,v 1.8 2004/11/12 08:23:46 eradicator Exp $

IUSE="jack"

inherit 64-bit eutils

DESCRIPTION="A clone of Impulse Tracker with some extensions and a built-in sample editor; uses QT"
HOMEPAGE="http://cheesetronic.sf.net/"
SRC_URI="mirror://sourceforge/cheesetronic/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

RDEPEND="jack? ( media-sound/jack-audio-connection-kit )
	=dev-libs/libsigc++-1.2*
	>=x11-libs/qt-3.0"

DEPEND="${RDEPEND}
	>=dev-util/scons-0.94-r2"

src_unpack() {
	unpack ${A}
	64-bit && epatch ${FILESDIR}/${P}-64bit-clean.diff
}

src_compile() {
	scons || die
}

src_install() {
	dodir /usr/bin
	scons prefix=${D}/usr install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO docs/*.txt
}
