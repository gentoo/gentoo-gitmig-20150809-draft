# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-vfs-extras/gnome-vfs-extras-0.99.6.ebuild,v 1.1 2002/11/13 16:40:29 foser Exp $

inherit gnome2

IUSE=""
S=${WORKDIR}/${P}
DESCRIPTION="the Gnome Virtual Filesystem extra libraries"
HOMEPAGE="http://www.gnome.org/"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~sparc64"

RDEPEND=">=gnome-base/gnome-vfs-2"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.20
	>=dev-util/pkgconfig-0.12.0"

unset CXXFLAGS  CFLAGS

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS  README"
