# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/prll/prll-0.6.ebuild,v 1.1 2011/05/20 06:19:45 jlec Exp $

EAPI=4

inherit eutils prefix toolchain-funcs

DESCRIPTION="A utility for parallelizing execution in bash or zsh"
HOMEPAGE="http://prll.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="app-text/txt2man"
RDEPEND=""

src_prepare() {
	tc-export CC
}

src_install() {
	dobin ${PN}_{qer,bfr}
	insinto /etc/profile.d/
	doins ${PN}.sh
	dodoc AUTHORS README NEWS
	doman ${PN}.1
}
