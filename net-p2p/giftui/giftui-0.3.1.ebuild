# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/giftui/giftui-0.3.1.ebuild,v 1.9 2005/01/14 20:05:31 squinky86 Exp $

IUSE=""
DESCRIPTION="A GTK+2 giFT frontend"
HOMEPAGE="http://giftui.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~amd64"

DEPEND=">=x11-libs/gtk+-2.0.3
	net-p2p/gift"

src_install() {
	make DESTDIR=${D} giftuidocdir=/usr/share/doc/${PF} install
	prepalldocs
}
