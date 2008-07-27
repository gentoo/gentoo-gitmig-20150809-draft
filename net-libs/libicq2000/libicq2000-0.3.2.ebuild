# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libicq2000/libicq2000-0.3.2.ebuild,v 1.7 2008/07/27 10:11:05 loki_val Exp $

inherit base autotools

DESCRIPTION="ICQ 200x compatible ICQ libraries."
SRC_URI="mirror://sourceforge/libicq2000/${P}.tar.gz"
HOMEPAGE="http://ickle.sf.net"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc "
IUSE=""

DEPEND="=dev-libs/libsigc++-1.0*"

PATCHES=( "${FILESDIR}/${P}-gcc43.patch" )

src_compile() {
	econf --enable-debug || die "econf failed"
	emake || die "emake failed"

}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS TODO
}
