# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/openobex/openobex-1.0.0.ebuild,v 1.7 2005/02/21 22:21:14 blubb Exp $

IUSE=""

DESCRIPTION="An implementation of the OBEX protocol used for transferring data to mobile devices"
SRC_URI="mirror://sourceforge/openobex/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/openobex"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~amd64"

DEPEND=">=dev-libs/glib-1.2"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc README AUTHORS NEWS
}
