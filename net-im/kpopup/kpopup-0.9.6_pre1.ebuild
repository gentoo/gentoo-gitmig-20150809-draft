# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kpopup/kpopup-0.9.6_pre1.ebuild,v 1.4 2004/09/04 17:10:32 axxo Exp $

inherit kde

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="An SMB Network Messenger"
HOMEPAGE="http://www.henschelsoft.de/kpopup.html"
SRC_URI="http://www.henschelsoft.de/kpopup/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-fs/samba"
need-kde 3
