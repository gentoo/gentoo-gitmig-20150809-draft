# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/dshieldpy/dshieldpy-3.2.ebuild,v 1.6 2005/07/26 11:25:16 dholm Exp $

DESCRIPTION="Python script to submit firewall logs to dshield.org"
HOMEPAGE="http://dshieldpy.sourceforge.net/"
SRC_URI="mirror://sourceforge/dshieldpy/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""
DEPEND="virtual/python"
RDEPEND=""
S=${WORKDIR}/DShield.py

src_install() {
	dodoc CHANGELOG COPYING README*
	dobin dshield.py

	insinto /etc
	doins dshieldpy.conf
}
