# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-mount/gnome-mount-0.4-r1.ebuild,v 1.2 2006/03/19 19:23:23 allanonjl Exp $

inherit eutils gnome2

DESCRIPTION="Wrapper for (un)mounting and ejecting disks"
HOMEPAGE="http://freedesktop.org/~david/"
SRC_URI="http://freedesktop.org/~david/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"

RDEPEND=">=gnome-base/libgnomeui-2.13
	>=sys-apps/dbus-0.60
	>=sys-apps/hal-0.5.7
	>=x11-libs/gtk+-2.8
	gnome-base/gnome-keyring
	>=gnome-base/libglade-2
	>=gnome-base/gconf-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

DOCS="AUTHORS ChangeLog COPYING HACKING INSTALL NEWS README TODO"
