# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-im/kmess/kmess-0.9.6.ebuild,v 1.4 2002/07/17 09:08:08 seemant Exp $

inherit kde-base || die

S="${WORKDIR}/${P}"
need-kde 3

DESCRIPTION="KDE MSN Messenger"
SRC_URI="mirror://sourceforge/kmess/${P}.tar.gz"
HOMEPAGE="http://kmess.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
