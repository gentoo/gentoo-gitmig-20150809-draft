# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aggregate/aggregate-1.6.ebuild,v 1.13 2007/04/22 08:48:42 kloeri Exp $

DESCRIPTION="aggregate takes a list of prefixes in conventional format on stdin, and performs two optimisations to reduce the length of the prefix list."
BASE_URI="http://dist.automagic.org/"
HOMEPAGE="${BASE_URI}"
SRC_URI="${BASE_URI}/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc sparc x86"
IUSE=""
DEPEND=""
RDEPEND="dev-lang/perl"

src_install() {
	dobin aggregate aggregate-ios
	doman aggregate.1 aggregate-ios.1
	dodoc LICENSE HISTORY
}
