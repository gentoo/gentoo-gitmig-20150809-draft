# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/extract-xiso/extract-xiso-2.4_beta2.ebuild,v 1.8 2004/11/12 20:27:49 blubb Exp $

MY_PV=${PV/_beta/b}
DESCRIPTION="Tool for extracting and creating optimised Xbox ISO images"
HOMEPAGE="http://sourceforge.net/projects/extract-xiso"
SRC_URI="mirror://sourceforge/extract-xiso/${PN}_src_v${MY_PV}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc ppc-macos ~amd64"
IUSE=""

DEPEND=""

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	sed -i -e "s:-O2:${CFLAGS}:g" ${S}/Makefile || die "sed failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin extract-xiso || die "dobin failed"
}
