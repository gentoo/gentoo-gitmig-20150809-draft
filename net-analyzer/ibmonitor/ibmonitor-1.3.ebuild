# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ibmonitor/ibmonitor-1.3.ebuild,v 1.4 2006/03/05 20:36:00 jokey Exp $

DESCRIPTION="Interactive bandwidth monitor"
HOMEPAGE="http://ibmonitor.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV}.tar.gz"

KEYWORDS="~hppa ~ppc x86"
IUSE=""

LICENSE="GPL-2"
SLOT="0"

S=${WORKDIR}/${PN}

DEPEND="dev-perl/TermReadKey"

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	dodir /usr/bin
	dobin ibmonitor

	dodoc AUTHORS ChangeLog README TODO
}
