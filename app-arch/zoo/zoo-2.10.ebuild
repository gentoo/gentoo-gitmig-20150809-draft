# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/zoo/zoo-2.10.ebuild,v 1.10 2003/09/05 22:49:03 msterret Exp $

DESCRIPTION="Manipulate archives of files in compressed form."
SRC_URI="ftp://ftp.kiarchive.ru/pub/unix/arcers/${P}pl1.tar.gz"

SLOT="0"
LICENSE="zoo"
KEYWORDS="x86 ppc sparc "

S=${WORKDIR}

src_unpack() {
	unpack ${P}pl1.tar.gz
	patch -p1 < ${FILESDIR}/${P}pl1.patch
}

src_compile() {
	emake linux || die
}

src_install() {
	dobin zoo fiz
	doman zoo.1 fiz.1
}
