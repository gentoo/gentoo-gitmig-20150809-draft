# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gnome-vfsmm/gnome-vfsmm-2.6.1.ebuild,v 1.1 2004/05/09 15:52:40 khai Exp $

inherit gnome2

DESCRIPTION="C++ bindings for gnome-vfs"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/sources/gnome-vfsmm/2.6/${P}.tar.bz2"
HOMEPAGE="http://gtkmm.sourceforge.net/"

IUSE=""
LICENSE="LGPL-2.1"
KEYWORDS="~x86"
SLOT="1.0"

RDEPEND=">=gnome-base/gnome-vfs-2.6
	>=dev-cpp/glibmm-2.4"

DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS COPYING* ChangeLog NEWS README INSTALL"
