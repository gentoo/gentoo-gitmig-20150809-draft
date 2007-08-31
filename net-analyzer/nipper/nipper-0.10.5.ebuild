# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nipper/nipper-0.10.5.ebuild,v 1.1 2007/08/31 07:32:24 ikelos Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Script to parse and report on Cisco config errors"
HOMEPAGE="http://www.sourceforge.net/projects/nipper"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

RESTRICT="mirror"

src_compile() {
	cd ${S}
	$(tc-getCC) ${CFLAGS} ${PN}.c -o${PN}
}

src_install() {
	dobin ${PN}
	dodoc Readme INSTALL LICENSE TODO Changelog docs/*
}
