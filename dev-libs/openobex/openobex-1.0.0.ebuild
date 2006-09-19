# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/openobex/openobex-1.0.0.ebuild,v 1.11 2006/09/19 07:36:45 mrness Exp $

IUSE=""

DESCRIPTION="An implementation of the OBEX protocol used for transferring data to mobile devices"
SRC_URI="mirror://sourceforge/openobex/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/openobex"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 sparc x86"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc README AUTHORS NEWS
}
