# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wifiscanner/wifiscanner-0.9.6.ebuild,v 1.1 2005/02/26 17:39:35 genstef Exp $

MY_P=WifiScanner-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="WifiScanner is an analyzer and detector of 802.11b stations and access points."
HOMEPAGE="http://wifiscanner.sourceforge.net/"
SRC_URI="mirror://sourceforge/wifiscanner/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86"
DEPEND="sys-libs/zlib
	sys-libs/ncurses
	net-libs/libpcap
	dev-libs/glib"

src_install () {
	make install DESTDIR=${D} || die
	dodoc AUTHORS BUG-REPORT-ADDRESS ChangeLog FAQ NEWS THANKS TODO doc/README
}
