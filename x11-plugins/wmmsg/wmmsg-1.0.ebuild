# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmsg/wmmsg-1.0.ebuild,v 1.1 2003/04/15 17:11:19 liquidx Exp $

DESCRIPTION="wmmsg is a dockapp that informs you of new events, such as incoming chat messages, by displaying related icons and arrival times"
HOMEPAGE="http://taxiway.swapspace.net/~matt/wmmsg/"
SRC_URI="http://taxiway.swapspace.net/~matt/wmmsg/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/x11
    =x11-libs/gtk+-1.2*
    media-libs/imlib2"
S=${WORKDIR}/${PN}

src_compile() {
	econf
	emake || die
}

src_install() {
	einstall
	dodoc AUTHORS COPYING INSTALL NEWS README TODO Changelog
	insinto /usr/share/doc/${PF}
	doins wmmsgrc
}
