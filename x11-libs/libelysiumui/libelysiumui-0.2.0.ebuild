# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libelysiumui/libelysiumui-0.2.0.ebuild,v 1.2 2003/06/20 08:52:38 liquidx Exp $

DESCRIPTION="User Interface enhancements for Elysium GNU/Linux"
HOMEPAGE="http://elysium-project.sourceforge.net"
SRC_URI="mirror://sourceforge/elysium-project/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/gconf-1.2"

src_install() {
	einstall || die "install failed"
}
