# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/io-vm/io-vm-20030923.ebuild,v 1.5 2004/10/18 12:25:28 dholm Exp $

MY_P=IoVM-${PV:0:4}-${PV:4:2}-${PV:6:2}
DESCRIPTION="Io is small prototype-based programming language."
HOMEPAGE="http://www.iolanguage.com/"
SRC_URI="http://io.urbanape.com/release/${MY_P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=""
S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i IoVM/Makefile -e 's/\(^LIBS := .*\)/\1 -ldl/'
}

src_compile() {
	make configure || die
	emake || die
}

src_install() {
	# copy the relevant portions by hand
	dobin IoVM/io
	dodoc IoVM/_docs/ReleaseHistory.txt
	dohtml -r IoVM/_docs/*
	# support for embedding
	dodir /usr/include/Io/base
	insinto /usr/include/Io
	doins IoVM/_include/*
	insinto /usr/include/Io/base
	doins IoVM/_include/base/*
	dolib IoVM/_libs/libIoVM.a
}
