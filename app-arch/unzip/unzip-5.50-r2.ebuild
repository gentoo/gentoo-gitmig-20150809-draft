# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unzip/unzip-5.50-r2.ebuild,v 1.1 2003/07/11 12:39:07 aliz Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Unzipper for pkzip-compressed files"
SRC_URI="ftp://ftp.info-zip.org/pub/infozip/src/${PN}${PV/.}.tar.gz"
HOMEPAGE="ftp://ftp.info-zip.org/pub/infozip/UnZip.html"

SLOT="0"
LICENSE="Info-ZIP"
KEYWORDS="x86 ppc alpha hppa mips arm"

DEPEND="virtual/glibc
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${P}-dotdot.patch
}

src_compile() {
	sed -i -e "s:-O3:${CFLAGS}:" \
		-e "s:CC=gcc LD=gcc:CC=${CC:-gcc} LD=${CC:-gcc}:" \
		-e "s:-O :${CFLAGS} :" unix/Makefile

	use x86 \
		&& TARGET=linux \
		|| TARGET=linux_noasm

	make -f unix/Makefile ${TARGET} || die
}

src_install() {
	dobin unzip funzip unzipsfx unix/zipgrep
	dosym /usr/bin/unzip /usr/bin/zipinfo
	doman man/*.1
	dodoc BUGS COPYING.OLD History* LICENSE README ToDo WHERE
}
