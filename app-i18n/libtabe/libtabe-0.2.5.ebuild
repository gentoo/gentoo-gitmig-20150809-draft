# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/libtabe/libtabe-0.2.5.ebuild,v 1.6 2003/11/03 23:37:46 liquidx Exp $

DESCRIPTION="Libtabe provides bimsphone support for xcin-2.5+"
HOMEPAGE="http://libtabe.sourceforge.net/"
SRC_URI="ftp://xcin.linux.org.tw/pub/xcin/libtabe/devel/${P}.tar.gz"

IUSE=""
LICENSE="XCIN"
SLOT="0"
KEYWORDS="x86"

DEPEND="=sys-libs/db-3*"
S="${WORKDIR}/${PN}"
MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-db3.patch 
}

src_compile() {

	econf \
		--with-db-inc=/usr/include/db3 \
		--with-db-lib=/usr/lib \
		--with-db-bin=/usr/bin \
		--enable-shared || die "econf failed"
	emake || die " make failed"
}

src_install() {
	einstall || die "install failed"
	dodoc doc/*
}
