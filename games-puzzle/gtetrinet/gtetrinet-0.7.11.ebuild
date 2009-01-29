# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gtetrinet/gtetrinet-0.7.11.ebuild,v 1.3 2009/01/29 02:36:31 mr_bones_ Exp $

EAPI=2
# games after gnome2 so games' functions will override gnome2's
inherit gnome2 games

DESCRIPTION="Tetrinet Clone for GNOME 2"
HOMEPAGE="http://gtetrinet.sourceforge.net/"
SRC_URI="${SRC_URI}
	mirror://gentoo/gtetrinet-gentoo-theme-0.1.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="nls ipv6"

RDEPEND="dev-libs/libxml2
	>=media-sound/esound-0.2.5
	>=gnome-base/gconf-2
	>=gnome-base/libgnome-2[esd]
	>=gnome-base/libgnomeui-2
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	sed -i \
		-e "/^pkgdatadir =/s:=.*:= ${GAMES_DATADIR}/${PN}:" \
		src/Makefile.in themes/*/Makefile.in || die "sed themes"
	sed -i \
		-e '/^LDADD/s:$: @ESD_LIBS@:' \
		-e '/^gamesdir/s:=.*:=@bindir@:' \
		src/Makefile.in || die "sed bindir"
}

src_configure() {
	econf \
		$(use_enable ipv6) \
		--bindir="${GAMES_BINDIR}" \
		|| die
}

src_install() {
	USE_DESTDIR=1 gnome2_src_install
	dodoc AUTHORS ChangeLog NEWS README TODO
	mv "${WORKDIR}"/gentoo "${D}/${GAMES_DATADIR}"/${PN}/themes/
	prepgamesdirs
}

pkg_preinst() {
	gnome2_pkg_preinst
	games_pkg_preinst
}

pkg_postinst() {
	SCROLLKEEPER_UPDATE=0
	gnome2_pkg_postinst
	games_pkg_postinst
}
