# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/devhelp/devhelp-0.5.0.ebuild,v 1.3 2003/06/10 12:55:55 liquidx Exp $

inherit gnome2

IUSE=""

DESCRIPTION="Developer help browser"
SRC_URI="http://devhelp.codefactory.se/download/${P}.tar.gz"
HOMEPAGE="http://devhelp.codefactory.se/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~ppc"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2.2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/gnome-vfs-2.2
	=gnome-extra/libgtkhtml-2*"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool"

DOCS="AUTHORS COPYING ChangeLog README NEWS TODO"

src_unpack() {
	unpack ${A}

	# fix the desktop item
	cd ${S}
	mv devhelp.desktop.in devhelp.desktop.in.old
	sed -e "s:Exec=devhelp-2:Exec=devhelp:" devhelp.desktop.in.old > devhelp.desktop.in
}
