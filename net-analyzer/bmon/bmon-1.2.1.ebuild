# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/bmon/bmon-1.2.1.ebuild,v 1.6 2005/01/09 06:41:21 dragonheart Exp $

DESCRIPTION="bmon is an interface bandwidth monitor."
HOMEPAGE="http://people.suug.ch/~tgr/bmon/"
SRC_URI="http://trash.net/~reeler/bmon/files/${P}.tar.bz2"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~amd64"
IUSE=""
DEPEND=">=sys-libs/ncurses-5.3-r2" # not sure but

src_install() {
	einstall || die
	cd ${S}
	dodoc AUTHORS COPYING ChangeLog
}
