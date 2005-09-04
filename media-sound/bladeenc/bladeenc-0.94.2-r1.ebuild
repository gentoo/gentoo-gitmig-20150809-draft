# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bladeenc/bladeenc-0.94.2-r1.ebuild,v 1.13 2005/09/04 11:05:39 flameeyes Exp $

IUSE=""

inherit eutils

DESCRIPTION="An mp3 encoder"
SRC_URI="http://bladeenc.mp3.no/source/${P}-src-stable.tar.gz"
HOMEPAGE="http://bladeenc.mp3.no/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc amd64 ppc64"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-secfix.diff
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README TODO
}
