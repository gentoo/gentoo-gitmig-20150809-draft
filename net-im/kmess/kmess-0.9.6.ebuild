# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/kmess/kmess-0.9.6.ebuild,v 1.2 2002/07/01 21:33:31 danarmak Exp $

inherit kde-base || die

S="${WORKDIR}/${P}"
need-kde 3
LICENSE="GPL-2"
DESCRIPTION="KDE MSN Messenger"
SRC_URI="mirror://sourceforge/kmess/${P}.tar.gz"
HOMEPAGE="http://kmess.sourceforge.net"
