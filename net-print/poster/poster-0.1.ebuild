# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/poster/poster-0.1.ebuild,v 1.8 2006/07/16 16:50:11 dertobi123 Exp $

inherit toolchain-funcs

S="${WORKDIR}/${PN}"
DESCRIPTION="small utility for making a poster from an EPS file or a one-page PS document"
SRC_URI="http://www.geocities.com/SiliconValley/5682/poster.tgz"
HOMEPAGE="http://www.geocities.com/SiliconValley/5682/poster.html"

LICENSE="poster"
KEYWORDS="~amd64 ppc x86"
SLOT="0"
IUSE=""

src_unpack() {
	unpack ${A}
	chmod u+rwx ./poster
	cd ${S}
	tar -zxf ./poster.tar.gz || die "tar failed"
}

src_compile(){
	`tc-getCC` ${CFLAGS} poster.c -lm -o ${PN} || die "compile failed"
}

src_install() {
	dobin ${PN} || die "dobin failed"
	doman ${PN}.1 || die "dodoc failed"
}
