# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-crystality/xmms-crystality-0.92.ebuild,v 1.6 2004/06/24 23:38:18 agriffis Exp $

IUSE=""

inherit eutils

MY_PN=crystality-plugin
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="xmms plugin to patch some of the mp3 format flaws in realtime"
HOMEPAGE="http://fanthom.math.put.poznan.pl/~gyver/crystality"
SRC_URI="http://fanthom.math.put.poznan.pl/~gyver/crystality/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND="media-sound/xmms"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc3.patch
}

src_compile() {
	emake CFLAGS="${CFLAGS} `gtk-config --cflags`" || die
}

src_install() {
	exeinto `xmms-config --effect-plugin-dir`
	doexe libcrystality.so
	dobin crystality-stdio
	dodoc README ChangeLog
}
