# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/magicdev/magicdev-1.1.7.ebuild,v 1.3 2004/11/25 20:53:19 leonardop Exp $

inherit gnome2

DESCRIPTION="A GNOME tool to automount/unmount removable media"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2.1.5
	>=gnome-base/libglade-2
	>=x11-libs/gtk+-2
	>=gnome-base/gconf-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

DOCS="AUTHORS ChangeLog README"
