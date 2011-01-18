# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libjwc_f/libjwc_f-1.1-r1.ebuild,v 1.6 2011/01/18 16:09:41 hwoarang Exp $

EAPI="2"

inherit autotools eutils

PATCH="612"

DESCRIPTION="additional fortran library for ccp4"
HOMEPAGE="http://www.ccp4.ac.uk/main.html"
SRC_URI="ftp://ftp.ccp4.ac.uk/jwc/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~x64-macos"

IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PATCH}-gentoo.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc NEWS README
	dohtml doc/*
}
