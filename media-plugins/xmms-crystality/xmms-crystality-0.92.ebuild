# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-crystality/xmms-crystality-0.92.ebuild,v 1.2 2004/04/09 10:51:55 dholm Exp $

inherit eutils

MY_PN=crystality-plugin
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="xmms plugin to patch some of the mp3 format flaws in realtime"
HOMEPAGE="http://xmms.org/plugins_search.html?mode=search&query=crystality"
SRC_URI="http://fanthom.math.put.poznan.pl/~gyver/crystality/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="media-sound/xmms
	>=sys-libs/glibc-2.1.3"

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
