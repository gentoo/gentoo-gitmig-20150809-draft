# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/examiner/examiner-0.5.ebuild,v 1.1 2002/08/19 04:11:03 blocke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Examiner is an application that utilizes the objdump command to disassemble and comment foreign executable binaries"
HOMEPAGE="http://www.academicunderground.org/examiner/"
SRC_URI="http://www.academicunderground.org/examiner/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="sys-devel/perl"

src_install() {

	dodir /usr/bin /usr/share/examiner /usr/share/man/man1
	dodir /usr/share/doc/examiner-0.5

	make MAN=${D}/usr/share/man/man1 DOC=${D}/usr/share/doc/examiner-0.5 \
		BIN=${D}/usr/bin SHARE=${D}/usr/share/examiner install
	dodoc docs/* 

	gzip ${D}/usr/share/doc/examiner-0.5/utils/*
}


