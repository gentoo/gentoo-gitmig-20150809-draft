# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unzip/unzip-5.52.ebuild,v 1.5 2005/08/16 13:23:04 gustavoz Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Unzipper for pkzip-compressed files"
HOMEPAGE="ftp://ftp.info-zip.org/pub/infozip/UnZip.html"
SRC_URI="ftp://ftp.info-zip.org/pub/infozip/src/${PN}${PV/.}.tar.gz"

LICENSE="Info-ZIP"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 m68k ~mips ~ppc ~ppc-macos ~ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:-O3:${CFLAGS}:" \
		-e "s:CC=gcc :CC=$(tc-getCC) :" \
		-e "s:LD=gcc :LD=$(tc-getCC) :" \
		-e "s:-O :${CFLAGS} :" \
		-e "s:LF2 = -s:LF2 = :" \
		unix/Makefile \
		|| die "sed unix/Makefile failed"
}

src_compile() {
	use x86 \
		&& TARGET=linux \
		|| TARGET=linux_noasm
	use userland_Darwin && TARGET=macosx
	emake -f unix/Makefile ${TARGET} || die "emake failed"
}

src_install() {
	dobin unzip funzip unzipsfx unix/zipgrep || die "dobin failed"
	dosym unzip /usr/bin/zipinfo
	doman man/*.1
	dodoc BUGS History* README ToDo WHERE
}
