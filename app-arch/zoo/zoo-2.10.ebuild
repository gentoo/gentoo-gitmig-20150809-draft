# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/zoo/zoo-2.10.ebuild,v 1.21 2005/02/06 18:20:31 corsair Exp $

inherit eutils

DESCRIPTION="Manipulate archives of files in compressed form."
SRC_URI="ftp://ftp.kiarchive.ru/pub/unix/arcers/${P}pl1.tar.gz"

SLOT="0"
LICENSE="zoo"
IUSE=""
KEYWORDS="x86 ppc sparc alpha amd64 ppc64"

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
