# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/vnc2swf/vnc2swf-0.4.2.ebuild,v 1.1 2004/12/15 15:34:06 vapier Exp $

DESCRIPTION="A tool for recording Shock wave Flash movies from vnc sessions"
HOMEPAGE="http://www.unixuser.org/~euske/vnc2swf"
SRC_URI="http://www.unixuser.org/~euske/vnc2swf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=">=media-libs/ming-0.2a
	virtual/libc
	virtual/x11"

src_install() {
	dobin vnc2swf || die "Install Failed"
	dodoc README TODO
}
