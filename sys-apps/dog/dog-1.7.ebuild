# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dog/dog-1.7.ebuild,v 1.12 2004/10/23 05:48:52 mr_bones_ Exp $

DESCRIPTION="Dog is better than cat"
SRC_URI="http://jl.photodex.com/dog/${P}.tar.gz"
HOMEPAGE="http://jl.photodex.com/dog/"

inherit ccc

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 alpha ppc64 sparc ppc ppc-macos"
DEPEND=">=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}; sed -i 's/^CFLAGS/#CFLAGS/' Makefile
	is-ccc && sed -i "s/gcc/${CC:-gcc}/" Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin dog
	doman dog.1
	dodoc README AUTHORS COPYING
}

