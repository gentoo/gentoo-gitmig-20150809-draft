# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dog/dog-1.7.ebuild,v 1.14 2004/10/28 15:55:48 vapier Exp $

inherit toolchain-funcs

DESCRIPTION="Dog is better than cat"
HOMEPAGE="http://jl.photodex.com/dog/"
SRC_URI="http://jl.photodex.com/dog/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 ppc-macos sparc x86"
IUSE=""

DEPEND=">=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's/^CFLAGS/#CFLAGS/' \
		-e "s/gcc/$(tc-getCC)/" \
		Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin dog || die
	doman dog.1
	dodoc README AUTHORS
}
