# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/babel/babel-1.6.ebuild,v 1.14 2004/03/26 12:05:17 phosphan Exp $

inherit eutils

DESCRIPTION="Babel is a program to interconvert file formats used in molecular modeling."

SRC_URI="http://smog.com/chem/babel/files/${P}.tar.Z"

HOMEPAGE="http://smog.com/chem/babel/"
KEYWORDS="x86 ppc sparc"
SLOT="0"
LICENSE="as-is"

#Doesn't really seem to depend on anything (?)
DEPEND="!app-sci/openbabel"

src_unpack() {

	unpack ${P}.tar.Z
	cd ${S}
#Patch the Makefile for gentoo-isms
	epatch ${FILESDIR}/${P}-gentoo.diff
	epatch ${FILESDIR}/${P}-gcc32.diff

}

src_compile() {

	emake || die

}

src_install () {

	make DESTDIR=${D}/usr/bin install || die

	insinto /usr/share/${PN}
	doins ${S}/*.lis

	insinto /etc/env.d
	doins ${FILESDIR}/10babel

	dodoc README.1ST

}

