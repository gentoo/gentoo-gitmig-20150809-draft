# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/oniguruma/oniguruma-2.1.0.ebuild,v 1.1 2004/02/07 07:54:00 usata Exp $

MY_DATE=20040202
MY_P="onigd${MY_DATE}"

DESCRIPTION="Regular expression library"
HOMEPAGE="http://raa.ruby-lang.org/list.rhtml?name=oniguruma"
SRC_URI="ftp://ftp.ruby-lang.org/pub/ruby/contrib/${MY_P}.tar.gz"

LICENSE="BSD"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc"

S=${WORKDIR}/${PN}

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-${MY_DATE}.diff
}

src_compile() {

	econf || die
	emake || die
}

src_install() {

	dodir /usr
	make prefix=${D}/usr install || die

	dodoc HISTORY README doc/*
}
