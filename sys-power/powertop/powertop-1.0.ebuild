# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/powertop/powertop-1.0.ebuild,v 1.1 2007/05/13 13:13:59 genstef Exp $

inherit toolchain-funcs

DESCRIPTION="PowerTOP is a Linux tool that finds the software component(s) that make your laptop use more power than necessary while it is idle."
HOMEPAGE="http://www.linuxpowertop.org"
SRC_URI="http://www.linuxpowertop.org/download/${P}.tar.gz"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""
S=${WORKDIR}/${PN}

src_compile() {
	echo $(tc-getCC) ${CFLAGS} ${LDFLAGS} powertop.c config.c -o powertop
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} powertop.c config.c -o powertop
}

src_install() {
	dobin powertop
}

pkg_postinst() {
	echo
	einfo "For PowerTOP to work best, use a Linux kernel with the" 
	einfo "tickless idle (NO_HZ) feature enabled (version 2.6.21 or later)."
	echo
}
