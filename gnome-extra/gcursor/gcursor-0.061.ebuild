# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gcursor/gcursor-0.061.ebuild,v 1.2 2005/01/31 15:02:52 gustavoz Exp $

inherit gnome2

DESCRIPTION="An X11 mouse cursor theme selector"
HOMEPAGE="http://qballcow.nl/?s=14"
SRC_URI="http://download.qballcow.nl/programs/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

IUSE=""
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/gconf-2
	>=app-arch/file-roller-2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12"

DOCS="AUTHORS ChangeLog TODO"

