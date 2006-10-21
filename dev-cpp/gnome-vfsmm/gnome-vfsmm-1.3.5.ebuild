# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gnome-vfsmm/gnome-vfsmm-1.3.5.ebuild,v 1.8 2006/10/21 10:54:40 dertobi123 Exp $

inherit gnome2

DESCRIPTION="C++ bindings for gnome-vfs"
SRC_URI="mirror://sourceforge/gtkmm/${P}.tar.gz"
HOMEPAGE="http://gtkmm.sourceforge.net/"

IUSE=""
LICENSE="LGPL-2.1"
KEYWORDS="ppc x86"
SLOT="1.0"

RDEPEND=">=gnome-base/gnome-vfs-2
	=dev-cpp/gtkmm-2.2*"

DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS COPYING* ChangeLog NEWS README INSTALL"
