# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/vis5d+/vis5d+-1.2.1.ebuild,v 1.6 2004/02/06 15:47:21 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="3dimensional weather modeling software"

SRC_URI="mirror://sourceforge/vis5d/${P}.tar.gz"

HOMEPAGE="http://vis5d.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"

DEPEND=">=app-sci/netcdf-3.5.0"

PROVIDE="app-sci/vis5d+"

src_compile() {

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--without-mixkit \
		--enable-threads || die "./configure failed"


	emake || die "emake failed"
}

src_install () {

	make DESTDIR=${D} install || die

	dodoc README NEWS INSTALL ChangeLog COPYING PORTING \
	     AUTHORS ABOUT-NLS


}
