# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/poster/poster-0.1.ebuild,v 1.5 2005/05/16 09:27:55 lanius Exp $

inherit toolchain-funcs

S="${WORKDIR}/${PN}"
DESCRIPTION="small utility for making a poster from an EPS file or a one-page PS document"
SRC_URI="http://www.geocities.com/SiliconValley/5682/poster.tgz"
HOMEPAGE="http://www.geocities.com/SiliconValley/5682/poster.html"

LICENSE="poster"
KEYWORDS="x86 ~amd64"
SLOT="0"
IUSE=""

src_unpack() {
	unpack ${A}
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
