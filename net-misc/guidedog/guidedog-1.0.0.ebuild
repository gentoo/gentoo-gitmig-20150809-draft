# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/guidedog/guidedog-1.0.0.ebuild,v 1.9 2009/11/12 16:40:18 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde

DESCRIPTION="A network/routing configuration utility for KDE 3"
HOMEPAGE="http://www.simonzone.com/software/guidedog/"
SRC_URI="http://www.simonzone.com/software/guidedog/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~sparc x86"
IUSE=""

DEPEND="net-firewall/iptables"

need-kde 3.5
