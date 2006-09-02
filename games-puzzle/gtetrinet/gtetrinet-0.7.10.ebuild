# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gtetrinet/gtetrinet-0.7.10.ebuild,v 1.1 2006/09/02 23:45:57 mr_bones_ Exp $

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
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^pkgdatadir =/s:=.*:= ${GAMES_DATADIR}/${PN}:" \
		src/Makefile.in themes/*/Makefile.in || die "sed themes"
	sed -i \
		-e '/^LDADD/s:$: @ESD_LIBS@:' \
		-e '/^gamesdir/s:=.*:=@bindir@:' \
		src/Makefile.in || die "sed bindir"
}

src_compile() {
	econf \
		$(use_enable ipv6) \
		--bindir="${GAMES_BINDIR}" \
		|| die
	emake || die "emake failed"
}

src_install() {
	USE_DESTDIR=1 gnome2_src_install
	dodoc AUTHORS ChangeLog NEWS README TODO
	mv "${WORKDIR}"/gentoo "${D}/${GAMES_DATADIR}"/${PN}/themes/
	prepgamesdirs
}

pkg_postinst() {
	SCROLLKEEPER_UPDATE=0
	gnome2_pkg_postinst
	games_pkg_postinst
}
