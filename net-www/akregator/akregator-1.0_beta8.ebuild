# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/akregator/akregator-1.0_beta8.ebuild,v 1.1 2004/11/29 00:25:27 motaboy Exp $

inherit kde

DESCRIPTION="KDE RSS aggregator."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://akregator.sf.net/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"

IUSE=""
SLOT="0"

need-kde 3.2
