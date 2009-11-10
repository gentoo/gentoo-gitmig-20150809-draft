# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/guidedog/guidedog-1.0.0.ebuild,v 1.8 2009/11/10 22:57:18 cla Exp $

ARTS_REQUIRED="never"
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
