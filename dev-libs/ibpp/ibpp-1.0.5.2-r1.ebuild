# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ibpp/ibpp-1.0.5.2-r1.ebuild,v 1.13 2004/04/21 16:40:03 vapier Exp $

inherit eutils

DESCRIPTION="IBPP, a C++ client API for firebird 1.0"
HOMEPAGE="http://www.ibpp.org/"
SRC_URI="mirror://sourceforge/ibpp/${P//./-}-src.zip"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="x86 -sparc"
IUSE=""

DEPEND=">=sys-apps/portage-2.0.47-r10
	>=dev-db/firebird-1.0"

src_unpack() {
	mkdir ${P}
	cd ${P}
	unpack ${A}
	epatch ${FILESDIR}/${P}.patch
	rm ibase.h iberror.h
}

src_compile() {
	emake PLATFORM="linux" || die
}

src_install() {
	insinto /usr/include
	doins ibpp.h || die "doins failed"
	cd release/linux
	dolib.so libibpp.so libibpp_core.so libibpp_helper.so || die "dolib.so failed"
	dolib.a libibpp.a libibpp_core.a libibpp_helper.a || die "dolib.a failed"
}
