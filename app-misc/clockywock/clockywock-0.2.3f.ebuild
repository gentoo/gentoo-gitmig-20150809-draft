# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/clockywock/clockywock-0.2.3f.ebuild,v 1.1 2011/01/31 20:29:11 ssuominen Exp $

EAPI=4
inherit eutils

MY_P=${P/f/F}

DESCRIPTION="ncurses based analog clock"
HOMEPAGE="http://dentar.com/open-source"
SRC_URI="https://dentar.com/opensource/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_install() {
	dobin ${PN}
	doman ${PN}.7
	dodoc README CREDITS
}
