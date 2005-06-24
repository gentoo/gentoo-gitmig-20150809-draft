# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/md5deep/md5deep-1.5-r1.ebuild,v 1.2 2005/06/24 13:45:21 liquidx Exp $

DESCRIPTION="Expanded md5sum program that has recursive and comparison options. Also includes SHA hash generation."
HOMEPAGE="http://md5deep.sourceforge.net"
SRC_URI="mirror://sourceforge/md5deep/${P}.tar.gz"
LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~ppc-macos"
IUSE=""
DEPEND=""

src_compile () {
    sed -i -e "s:-Wall -O2:\$(CFLAGS):g" Makefile
	BUILDTARGET="linux"
	use ppc-macos && BUILDTARGET="mac"
	make CFLAGS="${CFLAGS}" ${BUILDTARGET} || die
}

src_install() {
	dobin md5deep sha1deep sha256deep
	dodoc README CHANGES
	doman md5deep.1 sha1deep.1 sha256deep.1
}
