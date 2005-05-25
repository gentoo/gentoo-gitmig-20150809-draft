# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/extract-xiso/extract-xiso-2.4_beta2-r1.ebuild,v 1.1 2005/05/25 23:13:53 chrb Exp $

inherit eutils

MY_PV=${PV/_beta/b}
DESCRIPTION="Tool for extracting and creating optimised Xbox ISO images"
HOMEPAGE="http://sourceforge.net/projects/extract-xiso"
SRC_URI="mirror://sourceforge/extract-xiso/${PN}_src_v${MY_PV}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc ppc-macos amd64"
IUSE=""

DEPEND=""

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	sed -i -e "s:-O2:${CFLAGS}:g" ${S}/Makefile || die "sed failed"
	cd ${S}
	epatch ${FILESDIR}/${P}-64bitfix.patch
	epatch ${FILESDIR}/${P}-fnamefix.patch
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin extract-xiso || die "dobin failed"
}
