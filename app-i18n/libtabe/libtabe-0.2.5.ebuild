# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/libtabe/libtabe-0.2.5.ebuild,v 1.12 2004/09/07 07:54:33 usata Exp $

inherit eutils

DESCRIPTION="Libtabe provides bimsphone support for xcin-2.5+"
HOMEPAGE="http://libtabe.sourceforge.net/"
SRC_URI="ftp://xcin.linux.org.tw/pub/xcin/libtabe/devel/${P}.tar.gz"

LICENSE="XCIN"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="=sys-libs/db-3*"

S=${WORKDIR}/${PN}

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
	emake -j1 || die " make failed"
}

src_install() {
	einstall || die "install failed"
	dodoc doc/*
}
