# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/zip/zip-2.31.ebuild,v 1.10 2006/04/23 16:44:40 kumba Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Info ZIP (encryption support)"
HOMEPAGE="ftp://ftp.freesoftware.com/pub/infozip/Zip.html"
SRC_URI="ftp://ftp.info-zip.org/pub/infozip/src/zip${PV//.}.tar.gz
	crypt? ( ftp://ftp.icce.rug.nl/infozip/src/zcrypt29.zip )"

LICENSE="Info-ZIP"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc-macos ppc64 s390 sh sparc x86"
IUSE="crypt"

DEPEND="crypt? ( app-arch/unzip )"

src_unpack() {
	unpack ${A}
	use crypt && mv -f crypt.[ch] "${S}"
	cd "${S}"
	epatch "${FILESDIR}"/zip-2.3-unix_configure-pic.patch
	cd unix
	sed -i -e "s:-O2:${CFLAGS}:" Makefile
}

src_compile() {
	emake \
		-f unix/Makefile \
		CC="$(tc-getCC)" \
		CPP="$(tc-getCC) -E" \
		generic || die
}

src_install() {
	dobin zip zipcloak zipnote zipsplit || die
	doman man/zip.1
	dodoc BUGS CHANGES MANUAL README TODO WHATSNEW WHERE
}
