# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gnome-vfsmm/gnome-vfsmm-1.3.5.ebuild,v 1.1 2004/01/25 13:51:30 pyrania Exp $

inherit gnome2

DESCRIPTION="C++ bindings for gnome-vfs"
SRC_URI="mirror://sourceforge/gtkmm/${P}.tar.gz"
HOMEPAGE="http://gtkmm.sourceforge.net/"

IUSE=""
LICENSE="LGPL-2.1"
KEYWORDS="~x86"
SLOT="0"

RDEPEND=">=gnome-base/gnome-vfs-2
	>=dev-cpp/gtkmm-2"

DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS COPYING* ChangeLog NEWS README INSTALL"
