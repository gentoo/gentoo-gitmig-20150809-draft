# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/zoo/zoo-2.10.ebuild,v 1.2 2002/07/17 20:44:58 drobbins Exp $

DESCRIPTION="Manipulate archives of files in compressed form."

DEPEND="virtual/glibc"
SRC_URI="ftp://ftp.kiarchive.ru/pub/unix/arcers/${P}pl1.tar.gz"
SLOT="0"
src_unpack () {

	unpack ${P}pl1.tar.gz
	cd ${WORKDIR}
	patch -p1 < ${FILESDIR}/${P}pl1.patch
}

src_compile () {

	cd ${WORKDIR}

	emake linux || die
}

src_install () {

	cd ${WORKDIR}
	into /usr
	dobin zoo fiz 
	doman zoo.1 fiz.1
}
