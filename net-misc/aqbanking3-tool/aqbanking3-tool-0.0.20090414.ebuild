# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aqbanking3-tool/aqbanking3-tool-0.0.20090414.ebuild,v 1.3 2011/03/13 20:00:59 ssuominen Exp $

EAPI=3
inherit toolchain-funcs

DESCRIPTION="A commandline tool for the AqBanking interface"
HOMEPAGE="http://peter.schlaile.de/aqbanking/"
SRC_URI="mirror://gentoo/${P}.tar.lzma"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-libs/aqbanking"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

S=${WORKDIR}/${PN}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install || die
	dodoc xslt/*
}
