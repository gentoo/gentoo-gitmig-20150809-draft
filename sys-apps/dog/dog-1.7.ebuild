# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dog/dog-1.7.ebuild,v 1.15 2005/02/11 05:36:39 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Dog is better than cat"
HOMEPAGE="http://jl.photodex.com/dog/"
SRC_URI="http://jl.photodex.com/dog/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 ppc-macos sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${FILESDIR}/${PV}-manpage-touchup.patch
	sed -i \
		-e 's/^CFLAGS/#CFLAGS/' \
		-e "s/gcc/$(tc-getCC)/" \
		Makefile
}

src_install() {
	dobin dog || die
	doman dog.1
	dodoc README AUTHORS
}
