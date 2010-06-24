# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/rlog/rlog-1.3.7.ebuild,v 1.8 2010/06/24 22:35:03 ssuominen Exp $

inherit eutils

DESCRIPTION="A C++ logging library"
SRC_URI="http://arg0.net/users/vgough/download/${P}.tgz"
HOMEPAGE="http://arg0.net/wiki/rlog"
LICENSE="LGPL-2"
KEYWORDS="sparc"
SLOT="0"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc-4.3.patch"
}

src_install () {
	dodoc AUTHORS README
	emake DESTDIR="${D}" install || die "emake install failed"
}
