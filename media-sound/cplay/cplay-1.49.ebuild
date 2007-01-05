# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cplay/cplay-1.49.ebuild,v 1.12 2007/01/05 05:51:08 jer Exp $

IUSE="mp3 vorbis"

DESCRIPTION="A Curses front-end for various audio players."
SRC_URI="http://mask.tf.hut.fi/~flu/cplay/${P}.tar.gz"
HOMEPAGE="http://mask.tf.hut.fi/~flu/hacks/cplay/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 hppa ~ppc ppc64 sparc x86"

DEPEND=""
RDEPEND="virtual/python
	vorbis? ( media-sound/vorbis-tools )
	mp3? ( ||
		(
			media-sound/mpg321
			media-sound/madplay
			media-sound/splay
		) )"

src_install () {
	make PREFIX=${D}/usr recursive-install || die

	dosed "s:/usr/local:/usr:g" cplay
	dobin cplay
	doman cplay.1
	dodoc ChangeLog README TODO
}
