# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/gnome-mud/gnome-mud-0.10.7.ebuild,v 1.4 2008/03/22 10:27:38 remi Exp $

inherit gnome2 games

DESCRIPTION="GNOME MUD client"
HOMEPAGE="http://amcl.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="python zlib"

RDEPEND="=x11-libs/gtk+-2*
	=gnome-base/libgnome-2*
	=gnome-base/libgnomeui-2*
	>=gnome-base/libglade-2.0.1
	>=x11-libs/vte-0.10.26
	dev-perl/XML-Parser
	virtual/libintl
	python? ( >=dev-python/pygtk-1.99.13 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.23
	>=sys-devel/gettext-0.11.5
	app-text/scrollkeeper"

src_compile() {
	gnome2_src_compile \
		--enable-mapper \
		$(use_with python) \
		$(use_enable zlib mccp)
}

src_install() {
	DOCS="AUTHORS ChangeLog NEWS PLUGIN.API README ROADMAP" \
	gnome2_src_install

	# plugin directory
	keepdir /usr/share/gnome-mud || die "keepdir failed"

	# put the binary in the Gentoo place and clean it up
	dogamesbin "${D}/usr/games/gnome-mud" || die "dogamesbin failed"
	rm -f "${D}/usr/games/gnome-mud"
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
