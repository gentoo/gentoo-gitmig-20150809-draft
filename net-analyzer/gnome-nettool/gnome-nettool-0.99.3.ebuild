# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/gnome-nettool/gnome-nettool-0.99.3.ebuild,v 1.9 2005/02/17 09:02:17 joem Exp $

inherit gnome2

DESCRIPTION="Collection of network tools"
HOMEPAGE="http://www.gnome.org/projects/gnome-network/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
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

DOCS="AUTHORS ChangeLog INSTALL NEWS README TODO"

pkg_postinst() {
	einfo "Some functionality in this package depends on lowlevel network"
	einfo "tools that are not installed by this package at this point"
}
