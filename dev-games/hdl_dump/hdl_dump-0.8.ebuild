# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/hdl_dump/hdl_dump-0.8.ebuild,v 1.1 2005/04/11 04:31:39 vapier Exp $

MY_PV=${PV}-20050217
DESCRIPTION="game installer for playstation 2 HD Loader"
HOMEPAGE="http://hdldump.ps2-scene.org/"
SRC_URI="http://hdldump.ps2-scene.org/hdl_dumx-${MY_PV}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^CFLAGS /s:$: ${CFLAGS}:" \
		Makefile || die "sed cflags"
}

src_install() {
	dobin hdl_dump || die
	dodoc AUTHORS CHANGELOG test.sh
}
