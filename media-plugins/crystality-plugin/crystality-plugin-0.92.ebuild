# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/crystality-plugin/crystality-plugin-0.92.ebuild,v 1.4 2004/02/03 00:16:29 vapier Exp $

inherit eutils

DESCRIPTION="xmms plugin to patch some of the mp3 format flaws in realtime"
HOMEPAGE="http://xmms.org/plugins_search.html?mode=search&query=crystality"
SRC_URI="http://fanthom.math.put.poznan.pl/~gyver/crystality/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

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
	insinto `xmms-config --effect-plugin-dir`
	doins libcrystality.so
	dobin crystality-stdio
	dodoc README ChangeLog
}
