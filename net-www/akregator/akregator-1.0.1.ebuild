# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/akregator/akregator-1.0.1.ebuild,v 1.1 2005/03/22 08:47:39 greg_g Exp $

inherit kde

DESCRIPTION="KDE RSS aggregator."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://akregator.sf.net/"
LICENSE="GPL-2"

IUSE=""
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
SLOT="0"

DEPEND="!kde-base/akregator
	!>=kde-base/kdepim-3.4.0_alpha1"

need-kde 3.3
