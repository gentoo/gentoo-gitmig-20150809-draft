# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/at-poke/at-poke-0.1.0.ebuild,v 1.1 2002/06/01 13:33:13 spider Exp $

DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


DESCRIPTION="the accessibility poking tool"
HOMEPAGE="http://bugzilla.gnome.org"
LICENSE="GPL-2 LGPL-2.1"

RDEPEND=">=gnome-extra/at-spi-0.12.1
	>=x11-libs/gtk+-2.0.0
	>=gnome-base/libgnomeui-1.117.0
	>=gnome-extra/libgail-gnome-0.5.0"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

SRC_URI="ftp://ftp.gnome.org/pub/gnome/pre-gnome2/sources/${PN}/${P}.tar.bz2"
S=${WORKDIR}/${P}
SLOT="0"


src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--enable-platform-gnome-2 || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	#make \
	#	prefix=${D}/usr \
	#	mandir=${D}/usr/share/man \
	#	infodir=${D}/usr/share/info \
	#	install || die

	dodoc AUTHORS COPYING COPYING.LIB ChangeLog INSTALL NEWS README TODO
}
