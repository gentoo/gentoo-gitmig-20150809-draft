# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/zip/zip-2.3-r1.ebuild,v 1.22 2004/02/17 06:47:20 kumba Exp $

DESCRIPTION="Info ZIP"
SRC_URI="http://www.ibiblio.org/pub/Linux/distributions/gentoo/distfiles/${PN}23.tar.gz"
HOMEPAGE="ftp://ftp.freesoftware.com/pub/infozip/Zip.html"

SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64"
LICENSE="Info-ZIP"

src_unpack() {
	unpack ${A}
	cd ${S}/unix
	sed -i -e "s:-O2:${CFLAGS}:" Makefile
}

src_compile() {
	make -f unix/Makefile generic_gcc || die
}

src_install() {
	dobin zip zipcloak zipnote zipsplit
	doman man/zip.1
	dodoc BUGS CHANGES LICENSE MANUAL README TODO WHATSNEW WHERE
}
