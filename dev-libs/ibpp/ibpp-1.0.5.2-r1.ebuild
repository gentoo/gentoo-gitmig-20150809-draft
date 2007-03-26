# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ibpp/ibpp-1.0.5.2-r1.ebuild,v 1.16 2007/03/26 08:10:40 antarus Exp $

inherit eutils

DESCRIPTION="IBPP, a C++ client API for firebird 1.0"
HOMEPAGE="http://www.ibpp.org/"
SRC_URI="mirror://sourceforge/ibpp/${P//./-}-src.zip"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="x86 -sparc"
IUSE=""

RDEPEND=">=dev-db/firebird-1.0"
DEPEND="${RDEPEND}
	app-arch/unzip"

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
