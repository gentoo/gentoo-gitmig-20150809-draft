# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xstroke/xstroke-0.6.ebuild,v 1.2 2005/11/10 21:54:10 nelchael Exp $

DESCRIPTION="Gesture/Handwriting recognition engine for X"
HOMEPAGE="http://www.xstroke.org/"
SRC_URI="http://www.xstroke.org/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~mips ~hppa"
IUSE=""

DEPEND="virtual/x11"

src_install() {
	make DESTDIR="${D}" BINDIR=/usr/bin install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
