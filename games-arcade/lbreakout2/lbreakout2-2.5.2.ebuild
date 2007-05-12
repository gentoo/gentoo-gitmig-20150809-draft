# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/lbreakout2/lbreakout2-2.5.2.ebuild,v 1.7 2007/05/12 06:07:31 mr_bones_ Exp $

inherit flag-o-matic eutils games

levels_V=20070121
themes_V=20070121

DESCRIPTION="Breakout clone written with the SDL library"
HOMEPAGE="http://lgames.sourceforge.net/index.php?project=LBreakout2"
SRC_URI=" mirror://sourceforge/lgames/${P}.tar.gz
	mirror://sourceforge/lgames/${PN}-levelsets-${levels_V}.tar.gz
	themes? ( mirror://sourceforge/lgames/${PN}-themes-${themes_V}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86 ~x86-fbsd"
IUSE="themes"

DEPEND="media-libs/libpng
	sys-libs/zlib
	>=media-libs/libsdl-1.1.5
	media-libs/sdl-net
	media-libs/sdl-mixer"

GAMES_USE_SDL="nojoystick" #bug #139864

src_unpack() {
	unpack ${P}.tar.gz

	cd "${S}/client/levels"
	unpack ${PN}-levelsets-${levels_V}.tar.gz

	if use themes ; then
		mkdir "${WORKDIR}/themes"
		cd "${WORKDIR}/themes"
		unpack ${PN}-themes-${themes_V}.tar.gz

		# Delete a few duplicate themes (already shipped with lbreakout2
		# tarball). Some of them have different case than built-in themes, so it
		# is harder to just compare if the filename is the same.
		rm -f absoluteB.zip oz.zip moiree.zip
		for f in *.zip; do
			unzip -q "$f"  &&  rm -f "$f"  ||  die "unpacking ${f}"
		done
	fi
}

src_compile() {
	filter-flags -O?
	egamesconf \
		--enable-sdl-net \
		--with-docdir="/usr/share/doc/${PF}" \
		|| die
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"

	mv "${D}"/usr/share/doc/${PF}/{lbreakout2,html}
	dodoc AUTHORS README TODO ChangeLog

	if use themes ; then
		insinto "${GAMES_DATADIR}/lbreakout2/gfx"
		# The next operation is slow. I guess we should display some type of
		# progress or something, just like "make install" prints what it is
		# doing.
		doins -r "${WORKDIR}/themes/"*  || die "extra themes installation failed"
	fi

	newicon client/gfx/win_icon.png lbreakout2.png
	make_desktop_entry lbreakout2 LBreakout2

	prepgamesdirs
}
