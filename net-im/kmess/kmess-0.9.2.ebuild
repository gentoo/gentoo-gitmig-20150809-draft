# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/kmess/kmess-0.9.2.ebuild,v 1.1 2002/04/24 21:08:02 verwilst Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

S="${WORKDIR}/${P}"
need-kde 3
DESCRIPTION="KDE MSN Messenger"
SRC_URI="http://prdownloads.sourceforge.net/kmess/${P}-3.tar.gz"
HOMEPAGE="http://kmess.sourceforge.net"
