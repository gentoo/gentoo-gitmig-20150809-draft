# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/obexftp/obexftp-0.10.3.ebuild,v 1.1 2004/11/12 20:35:12 ticho Exp $

DESCRIPTION="File transfer over OBEX for mobile phones"
SRC_URI="mirror://sourceforge/openobex/${P}.tar.gz"
HOMEPAGE="http://triq.net/obex"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND="media-sound/gsm
	>=dev-libs/glib-1.2
	>=dev-libs/openobex-1.0.0"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_compile() {
	econf || die
	sed -i -e 's:apps vmo doc:apps vmo:' Makefile
	emake || die
}

src_install() {
	dohtml doc/*.html doc/*.css doc/*.png doc/*.xml doc/*.xsl
	doman doc/flexmem.1
	rm -rf doc
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog README* THANKS TODO
}
