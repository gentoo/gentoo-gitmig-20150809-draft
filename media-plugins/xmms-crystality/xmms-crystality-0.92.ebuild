# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-crystality/xmms-crystality-0.92.ebuild,v 1.8 2004/11/11 09:53:01 eradicator Exp $

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
# -sparc: 0.92: static noise when enabled
# ~amd64: 0.92: distortions in the effects... 
KEYWORDS="~amd64 ~ppc -sparc x86"

DEPEND="media-sound/xmms"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc3.patch
	epatch ${FILESDIR}/${P}-PIC.patch
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	exeinto `xmms-config --effect-plugin-dir`
	doexe libcrystality.so
	dobin crystality-stdio
	dodoc README ChangeLog
}
