# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgnomeuimm/libgnomeuimm-2.6.0.ebuild,v 1.3 2004/05/25 17:56:34 kugelfang Exp $

inherit gnome2 eutils

DESCRIPTION="C++ bindings for libgnomeui"
HOMEPAGE="http://gtkmm.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="1.1"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2.6
	>=dev-cpp/libgnomemm-2.6
	>=dev-cpp/libgnomecanvasmm-2.6
	>=dev-cpp/gconfmm-2.6
	>=dev-cpp/libglademm-2.4
	>=dev-cpp/gnome-vfsmm-2.6"
DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS INSTALL TODO"

src_compile() {
	aclocal -I scripts
	automake -c -f
	autoconf
	gnome2_src_compile
}
