# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aggregate/aggregate-1.6.ebuild,v 1.4 2004/02/22 23:27:33 agriffis Exp $

DESCRIPTION="aggregate takes a list of prefixes in conventional format on stdin, and performs two optimisations to reduce the length of the prefix list."
HOMEPAGE="http://dist.automagic.org/"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc ~alpha ~hppa ia64 amd64 ~sparc ~mips"
IUSE=""
DEPEND=""
RDEPEND="dev-lang/perl"
S=${WORKDIR}/${P}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	into /usr
	dobin aggregate aggregate-ios
	doman aggregate.1 aggregate-ios.1
	dodoc LICENSE HISTORY
}
