# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ysm/ysm-2.7.1.ebuild,v 1.7 2004/07/15 00:26:45 agriffis Exp $

MY_PV=${PV//./_}
DESCRIPTION="A console ICQ client supporting versions 7/8"
HOMEPAGE="http://ysmv7.sourceforge.net/"
SRC_URI="mirror://sourceforge/ysmv7/${PN}v7_${MY_PV}.tgz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/libc"
RDEPEND="virtual/libc"

S=${WORKDIR}/${PN}v7_${MY_PV}

src_compile() {
	cd ${S}
	sed -i -e "s:CFLAGS = -O2 -Wall -g:CFLAGS = ${CFLAGS}:" GNUmakefile

	emake || die
}

src_install () {
	dobin ysm
	doman docs/ysm.1
	dodoc docs/README docs/AUTHORS docs/COMMANDS docs/INSTALL
}
