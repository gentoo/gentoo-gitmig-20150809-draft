# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/enigma/enigma-0.80_beta1.ebuild,v 1.2 2003/09/24 20:42:07 msterret Exp $

inherit games

S="${WORKDIR}/enigma-0.80-beta"
DESCRIPTION="puzzle game similar to Oxyd"
HOMEPAGE="http://www.freesoftware.fsf.org/enigma/"
SRC_URI="http://savannah.nongnu.org/download/enigma/enigma-0.80-beta.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

DEPEND="virtual/glibc
	sys-libs/zlib
	media-libs/sdl-ttf
	>=media-libs/libsdl-1.2.0
	>=media-libs/sdl-mixer-1.2.4
	>=media-libs/sdl-image-1.2.0
	>=dev-lang/lua-4.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Ugly, but since this is beta, I'm going to do it anyhow.
	# I've notified upstream of the need for this patch so hopefully
	# the next release will have it included in the distributed tarball.
	epatch ${FILESDIR}/0.70-gcc3.patch
	epatch ${FILESDIR}/enigma-0.80-beta.patch
}

src_compile() {
	egamesconf --enable-optimize || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc NEWS README AUTHORS INSTALL ChangeLog
	prepgamesdirs
}
