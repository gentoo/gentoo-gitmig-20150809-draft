# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kmess/kmess-1.4.2.ebuild,v 1.1 2005/11/25 11:06:04 greg_g Exp $

inherit kde eutils

DESCRIPTION="MSN Messenger clone for KDE"
HOMEPAGE="http://kmess.sourceforge.net"
SRC_URI="mirror://sourceforge/kmess/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

need-kde 3
