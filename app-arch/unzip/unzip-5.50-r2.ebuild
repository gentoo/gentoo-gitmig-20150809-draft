# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unzip/unzip-5.50-r2.ebuild,v 1.17 2004/10/27 00:15:26 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Unzipper for pkzip-compressed files"
HOMEPAGE="ftp://ftp.info-zip.org/pub/infozip/UnZip.html"
SRC_URI="ftp://ftp.info-zip.org/pub/infozip/src/${PN}${PV/.}.tar.gz"

LICENSE="Info-ZIP"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-dotdot.patch

	sed -i \
		-e "s:-O3:${CFLAGS}:" \
		-e "s:CC=gcc LD=gcc:CC=$(tc-getCC) LD=$(tc-getCC):" \
		-e "s:-O :${CFLAGS} :" \
		unix/Makefile \
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
	dosym unzip /usr/bin/zipinfo
	doman man/*.1
	dodoc BUGS History* README ToDo WHERE
}
