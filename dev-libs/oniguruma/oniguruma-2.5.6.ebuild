# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/oniguruma/oniguruma-2.5.6.ebuild,v 1.1 2006/07/01 04:01:22 usata Exp $

MY_P="onigd${PV//./_}"

DESCRIPTION="Regular expression library"
HOMEPAGE="http://www.geocities.jp/kosako3/oniguruma/"
SRC_URI="http://www.geocities.jp/kosako3/oniguruma/archive/${MY_P}.tar.gz"

LICENSE="BSD"

SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc ~ppc-macos"
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
