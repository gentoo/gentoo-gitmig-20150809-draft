# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/akregator/akregator-1.0_beta3.ebuild,v 1.7 2005/01/14 23:06:08 danarmak Exp $

inherit kde

DESCRIPTION="KDE RSS aggregator."
SRC_URI="http://akregator.upnet.ru/akregator-1.0_beta3.tar.bz2"
HOMEPAGE="http://akregator.upnet.ru/"
DEPEND="!kde-base/akregator !>=kde-base/kdepim-3.4.0_alpha1"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"

IUSE=""
SLOT="0"

need-kde 3.2

