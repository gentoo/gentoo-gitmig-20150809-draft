# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/guarddog/guarddog-2.2.0.ebuild,v 1.8 2005/01/18 18:39:57 gustavoz Exp $

inherit kde

DESCRIPTION="Firewall configuration utility for KDE 3"
HOMEPAGE="http://www.simonzone.com/software/guarddog/"
SRC_URI="http://www.simonzone.com/software/guarddog/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
IUSE=""

RDEPEND=">=net-firewall/iptables-1.2.5"
need-kde 3