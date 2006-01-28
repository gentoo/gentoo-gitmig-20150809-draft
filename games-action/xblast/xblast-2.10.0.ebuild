# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/xblast/xblast-2.10.0.ebuild,v 1.2 2006/01/28 21:19:10 joshuabaergen Exp $

inherit eutils games

DESCRIPTION="Bomberman clone w/network support for up to 6 players"
HOMEPAGE="http://xblast.sourceforge.net/"
SRC_URI="mirror://sourceforge/xblast/${PN}-complete-sounds-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND="|| ( ( x11-libs/libICE
				x11-libs/libX11 )
			virtual/x11 )
	media-libs/libpng"
DEPEND="${RDEPEND}
	|| ( x11-libs/libXt virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-makefile.patch"
}

src_compile() {
	export MY_DATADIR="${GAMES_DATADIR}/${PN}"
	egamesconf \
		--enable-sound \
		--with-otherdatadir="${MY_DATADIR}" \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
	find "${D}" -name Imakefile -exec rm \{\} \;
	prepgamesdirs
}
