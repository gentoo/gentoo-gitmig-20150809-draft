# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/gnome-mud/gnome-mud-0.10.2-r1.ebuild,v 1.2 2003/12/15 06:12:02 mr_bones_ Exp $

inherit games gnome2

DESCRIPTION="GNOME MUD client"
SRC_URI="mirror://sourceforge/amcl/${P}.tar.gz"
HOMEPAGE="http://amcl.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

IUSE="python zlib"

RDEPEND="=x11-libs/gtk+-2*
	=gnome-base/libgnome-2*
	=gnome-base/libgnomeui-2*
	>=x11-libs/vte-0.10.26
	python? ( >=dev-python/pygtk-1.99.13 )
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.23
	>=sys-devel/gettext-0.11.5
	app-text/scrollkeeper"

use python || G2CONF="${G2CONF} --without-python"
G2CONF="${G2CONF} `use_enable zlib mccp`"

DOCS="AUTHORS BUGS ChangeLog NEWS PLUGIN.API README ROADMAP"

src_install() {
	gnome2_src_install

	# plugin directory
	dodir /usr/share/gnome-mud

	# put the binary in the Gentoo place
	cd ${D}/usr/games
	dogamesbin gnome-mud
	rm -f gnome-mud
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "For proper plugin operation, please create ~/.gnome-mud/plugins/"
	einfo "if that directory doesn't already exist."
	einfo "The command to do that is:"
	einfo "    mkdir -p ~/.gnome-mud/plugins/"
	echo
}
