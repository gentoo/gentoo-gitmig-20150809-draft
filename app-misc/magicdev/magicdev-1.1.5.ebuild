# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/magicdev/magicdev-1.1.5.ebuild,v 1.1 2004/01/16 03:21:46 leonardop Exp $

inherit gnome2

DESCRIPTION="A GNOME tool to automount/unmount removable media."
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~x86"
DEPEND=">=gnome-base/libgnomeui-2.1.5
	>=gnome-base/libglade-2
	>=x11-libs/gtk+-2
	>=gnome-base/gconf-2
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog COPYING README"
