# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libIDL/libIDL-0.8.1.ebuild,v 1.2 2003/05/05 12:16:00 foser Exp $

inherit gnome2

# FIXME : are these artifacts and can they be removed ?
# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"

S=${WORKDIR}/${P}
DESCRIPTION="CORBA tree builder"
HOMEPAGE="http://www.gnome.org"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

RDEPEND=">=dev-libs/glib-2
	>=sys-devel/flex-2.5.4"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

src_compile() {
	local myconf

	econf --enable-debug=yes || die
	emake || die
}

DOCS="AUTHORS BUGS COPYING ChangeLog INSTALL NEWS  README*"

