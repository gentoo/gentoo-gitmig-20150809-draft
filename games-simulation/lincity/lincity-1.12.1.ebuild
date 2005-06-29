# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/lincity/lincity-1.12.1.ebuild,v 1.3 2005/06/29 19:10:00 fmccor Exp $

inherit games

DESCRIPTION="city/country simulation game for X and Linux SVGALib"
HOMEPAGE="http://lincity.sourceforge.net/"
SRC_URI="mirror://sourceforge/lincity/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE="nls svga X"

# dep fix (bug #82318)
DEPEND="virtual/libc
	nls? ( sys-devel/gettext )
	svga? ( media-libs/svgalib )
	X? ( virtual/x11 )
	!X? ( !svga? ( virtual/x11 ) )"

src_compile() {
	local myconf=

	if ! use X && ! use svga ; then
		myconf="--with-x"
	fi
	egamesconf \
		--disable-dependency-tracking \
		--with-gzip \
		$(use_enable nls) \
		$(use_with svga) \
		$(use_with X x) \
		${myconf} \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc Acknowledgements CHANGES README* TODO || die "dodoc failed"
	if use nls ; then
		cd "${D}/${GAMES_DATADIR}"
		mv locale "${D}/usr/share/"
	fi
	prepgamesdirs
}
