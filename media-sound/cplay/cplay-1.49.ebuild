# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cplay/cplay-1.49.ebuild,v 1.9 2006/01/09 17:11:36 jer Exp $

IUSE=""

DESCRIPTION="A Curses front-end for various audio players."
SRC_URI="http://www.tf.hut.fi/~flu/cplay/${P}.tar.gz"
HOMEPAGE="http://www.tf.hut.fi/~flu/hacks/cplay/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~hppa ~ppc ppc64 sparc x86"

DEPEND=""
RDEPEND="virtual/python"

src_install () {
	make PREFIX=${D}/usr recursive-install || die

	dosed "s:/usr/local:/usr:g" cplay
	dobin cplay
	doman cplay.1
	dodoc ChangeLog README TODO
}
