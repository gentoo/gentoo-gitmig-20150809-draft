# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kmess/kmess-1.3.ebuild,v 1.5 2004/06/24 22:55:20 agriffis Exp $

inherit kde

need-kde 3

IUSE=""
DESCRIPTION="MSN Messenger clone for KDE"
SRC_URI="mirror://sourceforge/kmess/${P}.tar.gz"
HOMEPAGE="http://kmess.sourceforge.net"

LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~ppc"

DEPEND="kde-base/kdenetwork"
