# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libIDL/libIDL-0.8.0.ebuild,v 1.5 2002/09/21 11:49:09 bjb Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"

S=${WORKDIR}/${P}
DESCRIPTION="CORBA tree builder"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc sparc sparc64 alpha"

RDEPEND=">=dev-libs/glib-2.0.0
	>=sys-devel/flex-2.5.4"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

src_compile() {
	local myconf

	econf --enable-debug=yes || die
	emake || die
}

src_install() {
	einstall || die
    
	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS  README*
}
