# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cplay/cplay-1.47.ebuild,v 1.5 2004/03/27 02:45:05 eradicator Exp $

DESCRIPTION="A Curses front-end for various audio players."
SRC_URI="http://www.tf.hut.fi/~flu/cplay/old/${P}.tar.gz"
HOMEPAGE="http://www.tf.hut.fi/~flu/hacks/cplay/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

IUSE=""

DEPEND="virtual/python"

src_install () {
	make PREFIX=${D}/usr recursive-install || die

	dosed "s:/usr/local:/usr:g" cplay
	dobin cplay
	doman cplay.1
	dodoc ChangeLog README TODO
}
