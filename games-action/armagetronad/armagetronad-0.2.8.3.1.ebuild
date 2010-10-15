# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/armagetronad/armagetronad-0.2.8.3.1.ebuild,v 1.7 2010/10/15 12:39:40 ranger Exp $

EAPI=2
inherit autotools eutils gnome2-utils games

DESCRIPTION="3d tron lightcycles, just like the movie"
HOMEPAGE="http://armagetronad.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.src.tar.bz2
	!dedicated? (
		http://armagetron.sourceforge.net/addons/moviesounds_fq.zip
		http://armagetron.sourceforge.net/addons/moviepack.zip
	)"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="dedicated"

RDEPEND="dev-libs/libxml2
	!dedicated? (
		virtual/opengl
		virtual/glu
		media-libs/libsdl[X,audio,opengl,video]
		media-libs/sdl-image[jpeg,png]
		>=media-libs/jpeg-6b
		>=media-libs/libpng-1.2.40
	)"
DEPEND="${RDEPEND}
	!dedicated? ( app-arch/unzip )"

src_prepare() {
	sed -i \
		-e 's/png_check_sig/png_sig_cmp/' \
		configure.ac || die

	sed -i \
		-e '/^SUBDIRS/s/desktop//' \
		Makefile.am || die

	eautoreconf
}

src_configure() {
	local myconf
	use dedicated && myconf="--disable-glout"

	egamesconf \
		--enable-initscripts=/usr/share/doc/${PF}/examples \
		--disable-uninstall \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" armadocdir="/usr/share/doc/${PF}" install || die
	dodoc AUTHORS ChangeLog NEWS README*

	if ! use dedicated; then
		local hidir="/usr/share/icons/hicolor"
		insinto ${hidir}/48x48/apps
		doins desktop/icons/large/${PN}.png || die
		insinto ${hidir}/32x32/apps
		doins desktop/icons/medium/${PN}.png || die
		insinto ${hidir}/16x16/apps
		doins desktop/icons/small/${PN}.png || die

		make_desktop_entry armagetronad "Armagetron Advanced"

		insinto "${GAMES_DATADIR}"/${PN}
		doins -r ../moviepack ../moviesounds || die
	fi

	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
