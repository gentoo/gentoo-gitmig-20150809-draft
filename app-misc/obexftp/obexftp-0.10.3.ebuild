# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/obexftp/obexftp-0.10.3.ebuild,v 1.1 2003/10/01 06:57:49 george Exp $

IUSE=""

DESCRIPTION="File transfer over OBEX for Siemens mobile phones"
SRC_URI="http://triq.net/obexftp/${P}.tar.gz"
HOMEPAGE="http://triq.net/obexftp.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="gsm
	>=dev-libs/glib-1.2
	>=dev-libs/openobex-1.0.0"

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README* THANKS TODO
}
