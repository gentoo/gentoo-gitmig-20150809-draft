# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aggregate/aggregate-1.6.ebuild,v 1.15 2010/10/17 04:46:37 leio Exp $

inherit eutils

DESCRIPTION="aggregate takes a list of prefixes in conventional format on stdin, and performs two optimisations to reduce the length of the prefix list."
HOMEPAGE="http://dist.automagic.org/"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc sparc x86"
IUSE=""
DEPEND=""
RDEPEND="dev-lang/perl"

src_unpack() {
	unpack "${A}"
	epatch "${FILESDIR}"/${P}-build-fixup.patch
}

src_install() {
	dobin aggregate aggregate-ios
	doman aggregate.1 aggregate-ios.1
	dodoc LICENSE HISTORY
}
