# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kssh/kssh-0.6.ebuild,v 1.14 2004/06/28 20:05:43 carlo Exp $

inherit kde

HOMEPAGE="http://www.geocities.com/bilibao/kssh.html"
SRC_URI="http://www.geocities.com/bilibao/${P}-rc.tar.gz"
DESCRIPTION="KDE 3.x frontend for SSH"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~ppc"
IUSE=""

DEPEND=">=net-misc/openssh-3.1_p1"
need-kde 3