# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/apollon/apollon-0.9.3.ebuild,v 1.4 2004/06/25 00:28:08 agriffis Exp $

inherit kde
need-kde 3

DESCRIPTION="A KDE-based giFT GUI to search for and monitor downloads."
HOMEPAGE="http://apollon.sourceforge.net"
# we use "-2", because the developers re-released the package
SRC_URI="mirror://sourceforge/apollon/${P}-2.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 ~amd64 ~ppc"

newdepend ">=net-p2p/gift-0.11.4"

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog HowToGetPlugins.README README TODO || die
}
