# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sipcalc/sipcalc-1.1.2.ebuild,v 1.1 2004/11/20 14:22:18 ticho Exp $

IUSE=""
DESCRIPTION="Sipcalc is an advanced console-based IP subnet calculator."
HOMEPAGE="http://www.routemeister.net/projects/sipcalc/"
KEYWORDS="~x86"
SRC_URI="http://www.routemeister.net/projects/${PN}/files/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"

DEPEND="virtual/libc"

src_compile() {
#	econf --prefix="${D}" --bindir="${D}/usr/bin" --mandir="${D}/usr/man" || die "econf failed"
	econf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog AUTHORS COPYING INSTALL NEWS README TODO
}
