# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/magicdev/magicdev-1.1.6.ebuild,v 1.1 2004/03/10 02:32:57 leonardop Exp $

inherit gnome2

DESCRIPTION="A GNOME tool to automount/unmount removable media."
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~x86"
RDEPEND=">=gnome-base/libgnomeui-2.1.5
	>=gnome-base/libglade-2
	>=x11-libs/gtk+-2
	>=gnome-base/gconf-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

DOCS="AUTHORS ChangeLog COPYING README"
