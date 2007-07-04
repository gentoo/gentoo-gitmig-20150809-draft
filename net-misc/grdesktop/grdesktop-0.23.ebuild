# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/grdesktop/grdesktop-0.23.ebuild,v 1.9 2007/07/04 14:10:36 uberlord Exp $

inherit eutils gnome2

DESCRIPTION="Gtk2 frontend for rdesktop"
HOMEPAGE="http://www.nongnu.org/grdesktop/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86 ~x86-fbsd"

IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	>=gnome-base/libgnomeui-2
	net-misc/rdesktop
	>=gnome-base/gconf-2"

DEPEND="${RDEPEND}
	app-text/scrollkeeper"

G2CONF="${G2CONF} --with-keymap-path=/usr/share/rdesktop/keymaps/"

docs="AUTHORS ChangeLog NEWS README TODO"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Correct icon path. See bug #50295.
	sed -i -e 's:Icon=.*:Icon=grdesktop/icon.png:' grdesktop.desktop

	gnome2_omf_fix
}
