# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aggregate/aggregate-1.6.ebuild,v 1.16 2010/10/28 09:25:23 ssuominen Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="aggregate takes a list of prefixes in conventional format on stdin, and performs two optimisations to reduce the length of the prefix list."
HOMEPAGE="http://dist.automagic.org/"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc sparc x86"
IUSE=""

RDEPEND="dev-lang/perl"
DEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-build-fixup.patch
}

src_configure() {
	tc-export CC
	econf
}

src_install() {
	dobin aggregate aggregate-ios || die
	doman aggregate{,-ios}.1
	dodoc HISTORY
}
