# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dog/dog-1.7.ebuild,v 1.3 2003/06/07 07:54:00 rac Exp $

DESCRIPTION="Dog is better than cat"
SRC_URI="http://jl.photodex.com/dog/${P}.tar.gz"
HOMEPAGE="http://jl.photodex.com/dog/"

inherit ccc

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha"
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

