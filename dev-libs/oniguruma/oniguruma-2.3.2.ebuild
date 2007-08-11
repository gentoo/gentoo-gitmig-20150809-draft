# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/oniguruma/oniguruma-2.3.2.ebuild,v 1.5 2007/08/11 16:50:23 matsuu Exp $

MY_P="onigd${PV//./_}"

DESCRIPTION="Regular expression library"
HOMEPAGE="http://www.geocities.jp/kosako1/oniguruma/"
SRC_URI="http://www.geocities.jp/kosako1/oniguruma/archive/${MY_P}.tar.gz"

LICENSE="BSD-2"

SLOT="0"
KEYWORDS="x86 alpha ppc"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${PN}

src_compile() {

	econf || die
	emake || die
}

src_install() {

	dodir /usr
	make prefix=${D}/usr install || die

	dodoc HISTORY README doc/*
}
