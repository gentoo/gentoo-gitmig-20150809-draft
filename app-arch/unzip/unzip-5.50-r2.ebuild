# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unzip/unzip-5.50-r2.ebuild,v 1.9 2004/03/17 05:11:21 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Unzipper for pkzip-compressed files"
HOMEPAGE="ftp://ftp.info-zip.org/pub/infozip/UnZip.html"
SRC_URI="ftp://ftp.info-zip.org/pub/infozip/src/${PN}${PV/.}.tar.gz"

LICENSE="Info-ZIP"
SLOT="0"
KEYWORDS="x86 ppc alpha hppa mips amd64 ia64 sparc ppc64"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${P}-dotdot.patch

	sed -i \
		-e "s:-O3:${CFLAGS}:" \
		-e "s:CC=gcc LD=gcc:CC=${CC:-gcc} LD=${CC:-gcc}:" \
		-e "s:-O :${CFLAGS} :" unix/Makefile \
			|| die "sed unix/Makefile failed"

}

src_compile() {
	use x86 \
		&& TARGET=linux \
		|| TARGET=linux_noasm

	emake -f unix/Makefile ${TARGET} || die "emake failed"
}

src_install() {
	dobin unzip funzip unzipsfx unix/zipgrep || die "dobin failed"
	dosym /usr/bin/unzip /usr/bin/zipinfo
	doman man/*.1
	dodoc BUGS COPYING.OLD History* LICENSE README ToDo WHERE
}
