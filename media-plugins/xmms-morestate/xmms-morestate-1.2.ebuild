# Copyright 1999-2004 Gentoo Technologies, Inc.; alexf <acid DOT punk AT gmx DOT net>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-morestate/xmms-morestate-1.2.ebuild,v 1.1 2004/01/25 11:36:27 eradicator Exp $

DESCRIPTION=" XMMS Morestate restores ESD volume, song time, and playing/paused status"
SRC_URI="mirror://sourceforge/xmms-morestate/${P}.tar.gz"
HOMEPAGE="http://xmms-morestate.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~ppc64 ~sparc"
IUSE=""

DEPEND=">=media-sound/xmms-1.2.7"

src_compile() {
    econf || die "Configuration failed."
    emake || die "Make failed."
}

src_install() {
    make DESTDIR=${D} install || die "Install failed."
    dodoc AUTHORS ChangeLog INSTALL README
}
