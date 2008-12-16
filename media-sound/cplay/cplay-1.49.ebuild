# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cplay/cplay-1.49.ebuild,v 1.16 2008/12/16 19:09:47 flameeyes Exp $

DESCRIPTION="A Curses front-end for various audio players."
SRC_URI="http://mask.tf.hut.fi/~flu/cplay/${P}.tar.gz"
HOMEPAGE="http://mask.tf.hut.fi/~flu/hacks/cplay/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~ppc ppc64 sparc x86"
IUSE="mp3 vorbis"

DEPEND="sys-devel/gettext"
RDEPEND="dev-lang/python
	vorbis? ( media-sound/vorbis-tools )
	mp3? ( ||
		(
			virtual/mpg123
			media-sound/madplay
			media-sound/splay
		) )"

src_install () {
	emake PREFIX="${D}/usr" recursive-install || die "emake failed."

	sed -i -e "s:/usr/local:/usr:g" "${D}"/usr/bin/cplay || die "dosed failed."
	dobin cplay || die "dobin failed."
	doman cplay.1
	dodoc ChangeLog README TODO
}
