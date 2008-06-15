# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/rlog/rlog-1.4.ebuild,v 1.1 2008/06/15 18:46:14 vanquirius Exp $

inherit eutils

DESCRIPTION="A C++ logging library"
SRC_URI="http://rlog.googlecode.com/files/${P}.tar.gz"
HOMEPAGE="http://arg0.net/wiki/rlog"
LICENSE="LGPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
SLOT="0"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-1.3.7-gcc-4.3.patch"
}

src_install () {
	dodoc AUTHORS README
	emake DESTDIR="${D}" install || die "emake install failed"
}
