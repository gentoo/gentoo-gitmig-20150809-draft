# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/obexftp/obexftp-0.10.3.ebuild,v 1.3 2004/02/15 12:53:17 dholm Exp $

IUSE=""

DESCRIPTION="File transfer over OBEX for Siemens mobile phones"
SRC_URI="http://triq.net/obexftp/${P}.tar.gz"
HOMEPAGE="http://triq.net/obexftp.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND="gsm
	>=dev-libs/glib-1.2
	>=dev-libs/openobex-1.0.0"

src_compile() {
	econf || die
	sed -i 's:apps vmo doc:apps vmo:' Makefile
	emake || die
}

src_install() {
	dohtml doc/*.html doc/*.css doc/*.png doc/*.xml doc/*.xsl
	doman doc/flexmem.1
	rm -rf doc
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README* THANKS TODO
}
