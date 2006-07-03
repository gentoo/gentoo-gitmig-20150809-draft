# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/x2vnc/x2vnc-1.7.2.ebuild,v 1.1 2006/07/03 09:05:39 phosphan Exp $

DESCRIPTION="Control a remote computer running VNC from X"
HOMEPAGE="http://fredrik.hubbe.net/x2vnc.html"
SRC_URI="http://fredrik.hubbe.net/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="tcltk"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXScrnSaver
		x11-libs/libXext
		x11-libs/libXinerama )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-proto/scrnsaverproto
		x11-proto/xproto
		x11-proto/xineramaproto )
	virtual/x11 )
	tcltk? ( dev-tcltk/expect )"

src_install() {
	dodir /usr/share /usr/bin
	make DESTDIR=${D} install || die
	use tcltk && dobin contrib/tkx2vnc
	dodoc ChangeLog README
}
