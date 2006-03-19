# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ibpp/ibpp-2.3.4.0.ebuild,v 1.2 2006/03/19 22:31:31 halcy0n Exp $

inherit eutils

MY_P=${P//./-}-src

DESCRIPTION="IBPP, a C++ client API for firebird 1.0"
HOMEPAGE="http://www.ibpp.org/"
SRC_URI="mirror://sourceforge/ibpp/${MY_P}.zip"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-db/firebird-1.5.1"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack() {
	mkdir ${P}
	cd ${P}
	unpack ${A}
	cd ${S}

	use amd64 && epatch ${FILESDIR}/${P}-amd64.patch
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	insinto /usr/include
	doins ibpp.h || die "doins failed"
	cd release/linux
	dolib.so libibpp.so || die "dolib.so failed"
	dolib.a libibpp.a || die "dolib.a failed"
}
