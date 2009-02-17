# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/gnome-mud/gnome-mud-0.11.1.ebuild,v 1.1 2009/02/17 16:53:59 mr_bones_ Exp $

EAPI=1
inherit gnome2 games

DESCRIPTION="GNOME MUD client"
HOMEPAGE="http://live.gnome.org/GnomeMud"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gstreamer"

RDEPEND="x11-libs/gtk+:2
	>=gnome-base/libglade-2.0.1:2.0
	>=x11-libs/vte-0.11
	gstreamer? ( media-libs/gstreamer )
	dev-perl/XML-Parser
	dev-libs/libpcre
	net-libs/gnet:2
	virtual/libintl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.23
	>=sys-devel/gettext-0.11.5
	app-text/scrollkeeper"

src_compile() {
	gnome2_src_compile \
		--bindir="${GAMES_BINDIR}" \
		$(use_enable gstreamer)
}

src_install() {
	DOCS="AUTHORS BUGS ChangeLog NEWS PLUGIN.API README ROADMAP" \
	gnome2_src_install

	# plugin directory
	keepdir /usr/share/gnome-mud || die "keepdir failed"

	prepgamesdirs
}

pkg_preinst() {
	gnome2_pkg_preinst
	games_pkg_preinst
}

pkg_postinst() {
	gnome2_pkg_postinst
	games_pkg_postinst
	echo
	elog "For proper plugin operation, please create ~/.gnome-mud/plugins/"
	elog "if that directory doesn't already exist."
	elog "The command to do that is:"
	elog "    mkdir -p ~/.gnome-mud/plugins/"
	echo
}
