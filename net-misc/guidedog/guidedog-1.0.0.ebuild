# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/guidedog/guidedog-1.0.0.ebuild,v 1.7 2007/06/21 15:43:42 angelos Exp $

ARTS_REQUIRED="yes"
inherit kde

DESCRIPTION="A network/routing configuration utility for KDE 3"
HOMEPAGE="http://www.simonzone.com/software/guidedog/"
SRC_URI="http://www.simonzone.com/software/guidedog/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND=">=net-firewall/iptables-1.2.5"
need-kde 3
