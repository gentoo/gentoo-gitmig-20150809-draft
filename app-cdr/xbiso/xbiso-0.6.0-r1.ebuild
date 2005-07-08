# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/xbiso/xbiso-0.6.0-r1.ebuild,v 1.2 2005/07/08 16:00:47 dholm Exp $

inherit eutils

DESCRIPTION="Xbox xdvdfs ISO extraction utility"
HOMEPAGE="http://sourceforge.net/projects/xbiso/"
SRC_URI="mirror://sourceforge/xbiso/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-fnamecheck.patch
}

src_install() {
	dobin xbiso || die "install failed"
	dodoc README CHANGELOG
}
