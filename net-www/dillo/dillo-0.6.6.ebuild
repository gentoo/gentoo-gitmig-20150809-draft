# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/dillo/dillo-0.6.6.ebuild,v 1.4 2002/07/16 04:54:33 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Lean GTK+-based web browser"
SRC_URI="http://dillo.cipsga.org.br/download/${P}.tar.gz"
HOMEPAGE="http://dillo.cipsga.org.br"
KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/jpeg-6b
	>=sys-libs/zlib-1.1.3
	>=media-libs/libpng-1.2.1"

RDEPEND="$DEPEND"

src_compile() {
	econf || die
	emake || die
}

src_install () {

	dodir /etc

	make \
		DESTDIR=${D} \
		install || die

	dodoc AUTHORS COPYING ChangeLog ChangeLog.old INSTALL README NEWS

	docinto doc
	dodoc doc/*.txt doc/README

}
