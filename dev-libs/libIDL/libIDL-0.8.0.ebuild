# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libIDL/libIDL-0.8.0.ebuild,v 1.11 2003/08/03 02:13:36 vapier Exp $

inherit flag-o-matic
# Do _NOT_ strip symbols in the build!
RESTRICT="nostrip"
append-flags -g

DESCRIPTION="CORBA tree builder"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/sources/${PN}/0.8/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

RDEPEND=">=dev-libs/glib-2.0.0
	>=sys-devel/flex-2.5.4"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

src_compile() {
	econf --enable-debug=yes || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README*
}
