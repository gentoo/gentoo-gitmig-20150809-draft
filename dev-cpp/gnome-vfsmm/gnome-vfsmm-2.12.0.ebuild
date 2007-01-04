# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gnome-vfsmm/gnome-vfsmm-2.12.0.ebuild,v 1.14 2007/01/04 14:31:59 flameeyes Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"

inherit gnome2 autotools

DESCRIPTION="C++ bindings for gnome-vfs"
HOMEPAGE="http://gtkmm.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="1.1"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86"
IUSE=""

RDEPEND=">=gnome-base/gnome-vfs-2.6
	>=dev-cpp/glibmm-2.4"
DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS README INSTALL"

src_unpack() {
	gnome2_src_unpack
	AT_M4DIR="scripts" eautoreconf
}
