# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/vnc2swf/vnc2swf-0.3.ebuild,v 1.9 2005/07/11 23:07:15 swegener Exp $

SLOT="0"
DESCRIPTION="A tool for recording Shock wave Flash movies from vnc sessions"
SRC_URI="http://www.unixuser.org/~euske/vnc2swf/${P}.tar.gz"
HOMEPAGE="http://www.unixuser.org/~euske/vnc2swf"
LICENSE="GPL-2"
DEPEND=">=media-libs/ming-0.2a
		virtual/libc
		virtual/x11"
KEYWORDS="x86 ppc"
IUSE=""

src_install () {
	dobin vnc2swf || die "Install Failed"
	dodoc README TODO
}
