# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnet/gnet-1.1.9.ebuild,v 1.1 2003/05/07 12:57:32 foser Exp $

DESCRIPTION="GNet network library."
SRC_URI="http://www.gnetlibrary.org/src/${P}.tar.gz"
HOMEPAGE="http://www.gnetlibrary.org/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~ppc"

# yes, the >= is correct, this software can use both glib 1.2 and 2.0!
DEPEND=">=dev-libs/glib-1.2.0"
 
src_compile() {
	econf \
		--with-html-dir=${D}/usr/share/doc/${PF} \
		--sysconfdir=/etc \
		--localstatedir=/var/lib || die

	emake || die
}

src_install() {
	make \
		prefix=${D}/usr \
		datadir=${D}/usr/share \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
		install || die
	
	dodoc AUTHORS BUGS ChangeLog COPYING NEWS README TODO
}
