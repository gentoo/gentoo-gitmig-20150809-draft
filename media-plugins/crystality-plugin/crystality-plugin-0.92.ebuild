# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/crystality-plugin/crystality-plugin-0.92.ebuild,v 1.1 2003/06/22 03:57:14 jje Exp $

DESCRIPTION="Crystality XMMS Plugin tries to patch some of the mp3 format flaws in realtime. It consists of bandwidth extender, harmonic booster, and 3D echo."
HOMEPAGE="http://xmms.org/plugins_search.html?mode=search&query=crystality"
SRC_URI="http://fanthom.math.put.poznan.pl/~gyver/crystality/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-sound/xmms
	>=sys-libs/glibc-2.1.3"

S=${WORKDIR}/${P}

src_compile() {
	emake || die
	#make || die
}

src_install() {
	insinto `xmms-config --effect-plugin-dir`
	doins libcrystality.so
	insinto $D
	dobin crystality-stdio
	dodoc README COPYING ChangeLog
}

