# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/vis5d+/vis5d+-1.2.1.ebuild,v 1.7 2004/06/16 04:56:58 mr_bones_ Exp $

DESCRIPTION="3dimensional weather modeling software"
HOMEPAGE="http://vis5d.sourceforge.net"
SRC_URI="mirror://sourceforge/vis5d/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=">=app-sci/netcdf-3.5.0"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--without-mixkit \
		--enable-threads || die "./configure failed"

	emake || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc README NEWS INSTALL ChangeLog PORTING AUTHORS ABOUT-NLS
}
