# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/zip/zip-2.3-r4.ebuild,v 1.2 2004/11/06 15:02:56 corsair Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Info ZIP (encryption support)"
HOMEPAGE="ftp://ftp.freesoftware.com/pub/infozip/Zip.html"
SRC_URI="mirror://gentoo/${PN}${PV/./}.tar.gz
	crypt? ( ftp://ftp.icce.rug.nl/infozip/src/zcrypt29.zip )"

LICENSE="Info-ZIP"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ppc64 ~sparc ~x86"
IUSE="crypt"

DEPEND="crypt? ( app-arch/unzip )"

src_unpack() {
	unpack ${A}
	if use crypt; then
		mv -f crypt.h ${S}
		mv -f crypt.c ${S}
	fi
	cd ${S}
	epatch ${FILESDIR}/zip-2.3-unix_configure-pic.patch
	epatch ${FILESDIR}/zip-CAN-2004-1010.patch
	cd ${S}/unix
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
