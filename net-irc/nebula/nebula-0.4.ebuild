# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/nebula/nebula-0.4.ebuild,v 1.2 2005/06/09 20:03:39 swegener Exp $

DESCRIPTION="An IRC client for X11 and Motif"
HOMEPAGE="http://nebula-irc.sourceforge.net/"
SRC_URI="mirror://sourceforge/nebula-irc/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/x11
	x11-libs/openmotif"

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}
