# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Spider  <spider@gentoo.org>
# Maintainer: Spider  <spider@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libIDL/libIDL-0.7.4-r2.ebuild,v 1.1 2002/05/22 18:52:18 spider Exp $

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

RDEPEND=">=dev-libs/glib-2.0.0
		>=sys-devel/flex-2.5.4"
DEPEND="${RDEPEND} >=dev-util/pkgconfig-0.12.0"

src_compile() {
	local myconf

	./configure --host=${CHOST} \
		    --prefix=/usr \
			--sysconfdir=/etc \
		    --infodir=/usr/share/info \
		    --mandir=/usr/share/man \
		    --enable-debug=yes || die

	emake || die
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die
    
	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS  README*
}





