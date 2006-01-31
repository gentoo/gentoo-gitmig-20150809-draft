# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmemmon/wmmemmon-1.0.1.ebuild,v 1.12 2006/01/31 19:52:24 nelchael Exp $

IUSE=""
DESCRIPTION="A program to monitor memory/swap usages."
SRC_URI="http://www.sh.rim.or.jp/~ssato/src/${P}.tar.gz"
HOMEPAGE="http://www.sh.rim.or.jp/~ssato/dockapp/index.shtml#wmmemmon"

LICENSE="GPL-2"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
SLOT="0"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXt
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xextproto virtual/x11 )"

src_install () {

	einstall || die "make install failed"

	doman doc/wmmemmon.1
	dodoc AUTHORS ChangeLog THANKS TODO README
	dobin src/wmmemmon

}
