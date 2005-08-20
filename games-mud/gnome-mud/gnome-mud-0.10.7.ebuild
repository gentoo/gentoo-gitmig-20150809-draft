# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/gnome-mud/gnome-mud-0.10.7.ebuild,v 1.2 2005/08/20 14:20:02 metalgod Exp $

inherit games gnome2

DESCRIPTION="GNOME MUD client"
HOMEPAGE="http://amcl.sourceforge.net/"
SRC_URI="mirror://gnome/sources/${PN}/0.10/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"
SLOT="0"

IUSE="python zlib"

RDEPEND="=x11-libs/gtk+-2*
	=gnome-base/libgnome-2*
	=gnome-base/libgnomeui-2*
	>=gnome-base/libglade-2.0.1
	>=x11-libs/vte-0.10.26
	dev-perl/XML-Parser
	python? ( >=dev-python/pygtk-1.99.13 )
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.23
	>=sys-devel/gettext-0.11.5
	app-text/scrollkeeper"

pkg_setup() {
	use python || G2CONF="${G2CONF} --without-python"
	G2CONF="${G2CONF} `use_enable zlib mccp`"

	DOCS="AUTHORS BUGS ChangeLog NEWS PLUGIN.API README ROADMAP"
}

src_install() {
	gnome2_src_install

	# plugin directory
	keepdir /usr/share/gnome-mud || die "keepdir failed"

	# put the binary in the Gentoo place and clean it up
	dogamesbin "${D}/usr/games/gnome-mud" || die "dogamesbin failed"
	rm -f "${D}/usr/games/gnome-mud"
	prepgamesdirs
}

pkg_postinst() {
	gnome2_pkg_postinst
	games_pkg_postinst
	echo
	einfo "For proper plugin operation, please create ~/.gnome-mud/plugins/"
	einfo "if that directory doesn't already exist."
	einfo "The command to do that is:"
	einfo "    mkdir -p ~/.gnome-mud/plugins/"
	echo
}
