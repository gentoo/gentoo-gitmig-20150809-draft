# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gtetrinet/gtetrinet-0.7.4.ebuild,v 1.3 2004/02/20 06:53:35 mr_bones_ Exp $

# games after gnome2 so games' functions will override gnome2's
inherit gnome2 games

DESCRIPTION="Tetrinet Clone for GNOME 2"
HOMEPAGE="http://gtetrinet.sourceforge.net/"
SRC_URI="${SRC_URI}
	mirror://gentoo/gtetrinet-gentoo-theme-0.1.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls ipv6"

RDEPEND="dev-libs/libxml2
	>=media-sound/esound-0.2.5
	>=gnome-base/gconf-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_compile() {
	sed -i \
		-e "s:\$(datadir)/pixmaps:/usr/share/pixmaps:" \
			{.,icons,src}/Makefile.in || \
				die "sed Makefile.in failed"
	egamesconf \
		`use_enable ipv6` \
		--sysconfdir=/etc \
		|| die
	emake || die "emake failed"
}

src_install() {
	USE_DESTDIR=1
	gnome2_src_install
	dodoc AUTHORS ChangeLog NEWS README TODO

	# move some stuff around
	cd ${D}/${GAMES_PREFIX}
	mkdir bin && mv games/gtetrinet bin/
	rm -rf games && cd ${D}/${GAMES_DATADIR} && mv applications locale ../
	use nls || rm -rf ../locale
	mv ${WORKDIR}/gentoo ${D}/${GAMES_DATADIR}/${PN}/themes/

	prepgamesdirs
}

pkg_postinst() {
	SCROLLKEEPER_UPDATE=0
	gnome2_pkg_postinst
	games_pkg_postinst
}
