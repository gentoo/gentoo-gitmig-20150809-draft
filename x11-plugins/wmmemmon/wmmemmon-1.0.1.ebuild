# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmemmon/wmmemmon-1.0.1.ebuild,v 1.7 2004/09/02 18:22:40 pvdabeel Exp $

IUSE=""
DESCRIPTION="A program to monitor memory/swap usages."
SRC_URI="http://www.sh.rim.or.jp/~ssato/src/${P}.tar.gz"
HOMEPAGE="http://www.sh.rim.or.jp/~ssato/dockapp/index.shtml#wmmemmon"

LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64 ppc"
SLOT="0"

DEPEND="virtual/libc virtual/x11"

src_compile() {

	econf || die "configure failed"

	emake || die "parallel make failed"

}

src_install () {

	einstall || die "make install failed"

	doman doc/wmmemmon.1

	dodoc AUTHORS ChangeLog THANKS TODO README

	dobin src/wmmemmon

}

