# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/grdesktop/grdesktop-0.23.ebuild,v 1.12 2011/03/27 12:36:23 nirbheek Exp $

EAPI="1"

inherit eutils gnome2

DESCRIPTION="Gtk2 frontend for rdesktop"
HOMEPAGE="http://www.nongnu.org/grdesktop/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86 ~x86-fbsd"

IUSE=""

RDEPEND="x11-libs/gtk+:2
	>=gnome-base/libgnomeui-2
	net-misc/rdesktop
	gnome-base/gconf:2"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/pkgconfig-0.9"

G2CONF="${G2CONF} --with-keymap-path=/usr/share/rdesktop/keymaps/"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_unpack() {
	gnome2_src_unpack

	# Correct icon path. See bug #50295.
	sed -e 's:Icon=.*:Icon=grdesktop/icon.png:' \
		-i grdesktop.desktop || die "sed 1 failed"

	sed -e 's/\(GETTEXT_PACKAGE = \)@GETTEXT_PACKAGE@/\1grdesktop/g' \
		-i po/Makefile.in.in || die "sed 2 failed"
}
