# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavbreaker/wavbreaker-0.4.ebuild,v 1.2 2004/02/03 11:05:46 eradicator Exp $

DESCRIPTION="wavbreaker/wavmerge GTK2 utility to break or merge WAV file"
HOMEPAGE="http://huli.org/wavbreaker/"
SRC_URI="http://huli.org/wavbreaker/${P}.tar.gz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="dev-libs/libxml2
	>=x11-libs/gtk+-2.0
	virtual/glibc"

DOCS="ChangeLog COPYING INSTALL README NEWS"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gcc2_fix.patch
}

src_install() {
	make DESTDIR=${D} install
	dodoc ${DOCS}
}
