# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/zoo/zoo-2.10.ebuild,v 1.15 2004/03/12 11:11:07 mr_bones_ Exp $

DESCRIPTION="Manipulate archives of files in compressed form."
SRC_URI="ftp://ftp.kiarchive.ru/pub/unix/arcers/${P}pl1.tar.gz"

SLOT="0"
LICENSE="zoo"
KEYWORDS="x86 ppc sparc alpha ~amd64"

S=${WORKDIR}

src_unpack() {
	unpack ${P}pl1.tar.gz
	epatch ${FILESDIR}/${P}-gcc33-issues-fix.patch
}

src_compile() {
	emake linux || die
}

src_install() {
	dobin zoo fiz
	doman zoo.1 fiz.1
}
