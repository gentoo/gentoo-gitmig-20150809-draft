# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sflowtool/sflowtool-3.7.ebuild,v 1.2 2005/05/23 04:01:10 mr_bones_ Exp $

DESCRIPTION="sflowtool is a utility for collecting and processing sFlow data"
HOMEPAGE="http://www.inmon.com/technology/sflowTools.php"
SRC_URI="http://www.inmon.com/bin/${P}.tar.gz"

LICENSE="inmon-sflow"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README
}
