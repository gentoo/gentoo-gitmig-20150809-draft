# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/wtf/wtf-20021005.ebuild,v 1.1 2003/09/10 18:14:05 vapier Exp $

DESCRIPTION="translates acronyms for you"
HOMEPAGE="http://www.mu.org/~mux/wtf/"
SRC_URI="http://www.mu.org/~mux/wtf/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa"

DEPEND=">=sys-apps/sed-4"

src_compile() {
	sed -i -e 's:/local/:/:' wtf || die "sed wtf failed"
}

src_install() {
	dobin wtf
	doman wtf.6
	insinto /usr/share/misc
	doins acronyms
}
