# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kmess/kmess-0.9.8.ebuild,v 1.2 2003/02/13 14:10:37 vapier Exp $

inherit kde-base || die

S="${WORKDIR}/${P}"
need-kde 3

DESCRIPTION="KDE MSN Messenger"
SRC_URI="mirror://sourceforge/kmess/${P}.tar.gz"
HOMEPAGE="http://kmess.sourceforge.net"


LICENSE="GPL-2"
KEYWORDS="x86"
