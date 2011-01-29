# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fdupes/fdupes-1.50_pre2.ebuild,v 1.8 2011/01/29 17:23:48 armin76 Exp $

EAPI=3

inherit eutils toolchain-funcs

MY_P="${PN}-${PV/_pre/-PR}"

DESCRIPTION="Identify/delete duplicate files residing within specified directories"
HOMEPAGE="http://netdial.caribe.net/~adrian2/fdupes.html"
SRC_URI="http://netdial.caribe.net/~adrian2/programs/${PN}/beta/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 s390 sparc x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	dobin fdupes || die
	doman fdupes.1 || die
	dodoc CHANGES CONTRIBUTORS README TODO || die
}
