# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/zip/zip-2.3-r3.ebuild,v 1.1 2004/09/28 19:23:31 solar Exp $

inherit gcc eutils

DESCRIPTION="Info ZIP (encryption support)"
HOMEPAGE="ftp://ftp.freesoftware.com/pub/infozip/Zip.html"
SRC_URI="mirror://gentoo/${PN}${PV/./}.tar.gz
	crypt? ( ftp://ftp.icce.rug.nl/infozip/src/zcrypt29.zip )"

LICENSE="Info-ZIP"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~ia64 ~hppa ~mips ~ppc64"
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
	cd ${S}/unix
	sed -i -e "s:-O2:${CFLAGS}:" Makefile
}

src_compile() {
	emake \
		-f unix/Makefile \
		CC="$(gcc-getCC)" \
		CPP="$(gcc-getCC) -E" \
		generic || die
}

src_install() {
	dobin zip zipcloak zipnote zipsplit
	doman man/zip.1
	dodoc BUGS CHANGES LICENSE MANUAL README TODO WHATSNEW WHERE
}
