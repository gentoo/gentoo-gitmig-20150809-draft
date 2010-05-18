# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/prll/prll-0.5.ebuild,v 1.1 2010/05/18 07:02:14 jlec Exp $

EAPI="2"

inherit eutils prefix toolchain-funcs

DESCRIPTION="A utility for parallelizing execution in bash or zsh"
HOMEPAGE="http://prll.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~x86-linux ~amd64-linux"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${PV}-prefix.patch
	tc-export CC
	eprefixify ${PN}.sh
}

src_install() {
	dobin ${PN}_{qer,bfr} || die
	insinto /etc/profile.d/
	doins ${PN}.sh || die
	dodoc ChangeLog AUTHORS README NEWS || die
}
