# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libglademm/libglademm-2.2.0.ebuild,v 1.5 2004/11/07 17:11:25 sekretarz Exp $

MY_PV=2.2
inherit gnome2 eutils
IUSE=""
DESCRIPTION="C++ bindings for libglade"
HOMEPAGE="http://gtkmm.sourceforge.net/"
SRC_URI="mirror://gnome/sources/libglademm/${MY_PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~hppa"

RDEPEND=">=gnome-base/libglade-2
	=dev-cpp/gtkmm-2.2*"
DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

# Needed for 2.0.0, it misses some make/libtool magic
# export SED=sed

DOCS="AUTHORS COPYING ChangeLog NEWS README TODO INSTALL"
src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gcc34.patch
	epatch ${FILESDIR}/${P}-configure.patch
}
