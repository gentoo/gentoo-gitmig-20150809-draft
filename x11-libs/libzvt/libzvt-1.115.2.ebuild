# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Spider  <spider@gentoo.org>
# Maintainer: Spider <spider@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libzvt/libzvt-1.115.2.ebuild,v 1.1 2002/05/22 18:58:37 spider Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


S=${WORKDIR}/${P}
DESCRIPTION="Zed's Virtual Terminal Library"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/libzvt/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"

RDEPEND=">=dev-libs/glib-2.0.0
	>=x11-libs/gtk+-2.0.0
	>=media-libs/libart_lgpl-2.3.8-r1"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"
src_compile() {
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
    
	dodoc ABOUT* AUTHORS COPY* ChangeLog INSTALL NEWS README 
	docinto libzvt
	dodoc libzvt/AUTHORS libzvt/BUGS libzvt/README libzvt/TODO
}





