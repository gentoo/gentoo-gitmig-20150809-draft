# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/zip/zip-2.3-r2.ebuild,v 1.15 2004/01/16 20:57:17 darkspecter Exp $

IUSE="crypt"

DESCRIPTION="Info ZIP (encryption support)"
HOMEPAGE="ftp://ftp.freesoftware.com/pub/infozip/Zip.html"
SRC_URI="mirror://gentoo/${PN}${PV/./}.tar.gz
	crypt? ( ftp://ftp.icce.rug.nl/infozip/src/zcrypt29.zip )"

SLOT="0"
LICENSE="Info-ZIP"
KEYWORDS="x86 ppc sparc alpha amd64 ia64 hppa"

DEPEND="crypt? ( app-arch/unzip )"

src_unpack() {
	unpack ${A}
	if [ "`use crypt`" ]; then
		mv -f crypt.h ${S}
		mv -f crypt.c ${S}
	fi
	cd ${S}/unix
	sed -i -e "s:-O2:${CFLAGS}:" Makefile
}

src_compile() {
	emake -f unix/Makefile generic_gcc || die
}

src_install() {
	dobin zip zipcloak zipnote zipsplit
	doman man/zip.1
	dodoc BUGS CHANGES LICENSE MANUAL README TODO WHATSNEW WHERE
}
