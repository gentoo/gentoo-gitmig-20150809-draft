# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/io-vm/io-vm-20030810.ebuild,v 1.1 2003/08/16 01:19:09 avenj Exp $

MY_P=IoVM-2003-08-10

DESCRIPTION="Io is small prototype-based programming language."
HOMEPAGE="http://www.iolanguage.com/"
SRC_URI="http://io.urbanape.com/release/${MY_P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
S=${WORKDIR}/${MY_P}

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
