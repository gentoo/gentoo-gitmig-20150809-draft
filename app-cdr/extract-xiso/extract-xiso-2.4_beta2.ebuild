# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/extract-xiso/extract-xiso-2.4_beta2.ebuild,v 1.3 2004/07/25 18:39:49 alexander Exp $

MY_PV=${PV/_beta/b}
S=${WORKDIR}/${PN}
SRC_URI="mirror://sourceforge/extract-xiso/${PN}_src_v${MY_PV}.tgz"
DESCRIPTION="Tool for extracting and creating optimised Xbox ISO images"
HOMEPAGE="http://sourceforge.net/projects/extract-xiso"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~ppc macos"
IUSE=""
DEPEND=""

src_unpack() {
	unpack ${A}
	sed -i -e "s:-O2:${CFLAGS}:g" ${S}/Makefile
}

src_compile() {
	emake
}

src_install() {
	dobin extract-xiso
}
