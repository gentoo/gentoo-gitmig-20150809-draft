# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/libtabe/libtabe-0.2.5.ebuild,v 1.5 2003/06/29 22:12:04 aliz Exp $

DESCRIPTION="Libtabe provides bimsphone support for xcin-2.5+"
HOMEPAGE="http://libtabe.sourceforge.net/"
SRC_URI="ftp://xcin.linux.org.tw/pub/xcin/libtabe/devel/${P}.tar.gz"

LICENSE="XCIN"
SLOT="0"
KEYWORDS="x86"

DEPEND="=sys-libs/db-3*"
S="${WORKDIR}/${PN}"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--with-db-inc=/usr/include/db3 \
		--with-db-lib=/usr/lib \
		--with-db-bin=/usr/bin \
		--enable-shared || die "./configure failed"
	make || die
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
	dodoc doc/*
}
