# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libunicode/libunicode-0.4-r1.ebuild,v 1.22 2004/01/02 19:40:26 aliz Exp $

inherit gnuconfig

S=${WORKDIR}/${P}
DESCRIPTION="Unicode library"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/sources/${PN}/${PV}/${P}.gnome.tar.gz"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 ppc sparc alpha hppa ~amd64"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A} || die
	cd ${S}
	use alpha && gnuconfig_update
	use amd64 && gnuconfig_update
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING.* ChangeLog NEWS README THANKS TODO
}
