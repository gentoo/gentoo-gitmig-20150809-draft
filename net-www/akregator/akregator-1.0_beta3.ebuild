# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/akregator/akregator-1.0_beta3.ebuild,v 1.1 2004/06/23 01:50:18 absinthe Exp $

inherit kde
need-kde 3

DEPEND=">=kde-base/kdelibs-3.2"

DESCRIPTION="KDE RSS aggregator."
SRC_URI="http://akregator.upnet.ru/akregator-1.0_beta3.tar.bz2"
HOMEPAGE="http://akregator.upnet.ru/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

IUSE=""
SLOT="0"

