# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/akregator/akregator-1.0_beta7.ebuild,v 1.2 2005/01/14 23:06:08 danarmak Exp $

inherit kde

DESCRIPTION="KDE RSS aggregator."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://akregator.sf.net/"
DEPEND="!kde-base/akregator !>=kde-base/kdepim-3.4.0_alpha1"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"

IUSE=""
SLOT="0"

need-kde 3.2
