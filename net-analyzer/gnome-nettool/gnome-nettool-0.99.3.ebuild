# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/gnome-nettool/gnome-nettool-0.99.3.ebuild,v 1.7 2004/10/25 21:23:07 agriffis Exp $

inherit gnome2

DESCRIPTION="Collection of network tools"
HOMEPAGE="http://www.gnome.org/projects/gnome-network/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc ~mips ~hppa ~ia64"

IUSE=""

# FIXME : probably missing runtime deps for gathering network statistics

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2.4
	>=gnome-base/gconf-1.2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README TODO"

pkg_postinst() {

	einfo "Some functionality in this package depends on lowlevel network"
	einfo "tools that are not installed by this package at this point."

}
