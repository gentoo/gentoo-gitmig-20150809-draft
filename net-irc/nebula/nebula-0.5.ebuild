# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/nebula/nebula-0.5.ebuild,v 1.4 2010/10/10 18:04:53 ulm Exp $

EAPI=1

DESCRIPTION="An IRC client for X11 and Motif"
HOMEPAGE="http://nebula-irc.sourceforge.net/"
SRC_URI="mirror://sourceforge/nebula-irc/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=x11-libs/openmotif-2.3:0"
RDEPEND="${DEPEND}"

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}
