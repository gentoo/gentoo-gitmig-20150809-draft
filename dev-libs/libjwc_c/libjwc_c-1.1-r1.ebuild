# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libjwc_c/libjwc_c-1.1-r1.ebuild,v 1.2 2010/07/29 23:21:47 darkside Exp $

EAPI="2"

inherit autotools eutils

PATCH="612"

DESCRIPTION="additional c library for ccp4"
HOMEPAGE="http://www.ccp4.ac.uk/main.html"
SRC_URI="ftp://ftp.ccp4.ac.uk/jwc/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~x64-macos"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${PATCH}-gentoo.patch
	rm missing || die
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README NEWS || die
}
