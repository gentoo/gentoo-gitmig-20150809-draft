# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/nebula/nebula-0.5.ebuild,v 1.2 2006/03/16 13:31:00 caleb Exp $

DESCRIPTION="An IRC client for X11 and Motif"
HOMEPAGE="http://nebula-irc.sourceforge.net/"
SRC_URI="mirror://sourceforge/nebula-irc/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="x11-libs/openmotif"

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}
