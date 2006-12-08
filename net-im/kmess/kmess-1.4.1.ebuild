# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kmess/kmess-1.4.1.ebuild,v 1.2 2006/12/08 12:41:49 deathwing00 Exp $

inherit kde eutils

DESCRIPTION="MSN Messenger clone for KDE"
HOMEPAGE="http://www.kmess.org"
SRC_URI="mirror://sourceforge/kmess/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

need-kde 3
