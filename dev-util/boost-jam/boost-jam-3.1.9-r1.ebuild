# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/boost-jam/boost-jam-3.1.9-r1.ebuild,v 1.5 2006/04/01 19:51:55 agriffis Exp $

IUSE=""

inherit eutils

DESCRIPTION="Boost.Jam - an alternative to make based on Jam."
HOMEPAGE="http://www.boost.org/tools/build/jam_src/index.html"
SRC_URI="mirror://sourceforge/boost/${P}.tgz"
RESTRICT="nomirror"

LICENSE="as-is"
SLOT="0"

KEYWORDS="~amd64 ~ia64 ~ppc ~x86"

DEPEND="dev-libs/boost
	!dev-util/jam"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-dir.patch
	epatch ${FILESDIR}/${P}-amd64.patch
}

src_compile() {
	./build.sh
}

src_install() {
	dodoc boost-jam.spec Porting LICENSE_1_0.txt
	dohtml Jam.html

	cd ${S}/bin.linux${ARCH}
	dobin bjam jam mkjambase yyacc || die "Unable to install binaries."
	/* add check or ebuild will happilly succeed on unsupported archs and install only docs */
}

pkg_postinst() {
	einfo "Sample code is available in /usr/share/boost/v2/example"
}
