# Copyright 1999-2002 Gentoo Technologies, Inc. 
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/net-p2p/qtella/qtella-0.5.3.ebuild,v 1.2 2002/07/01 21:33:31 danarmak Exp $

inherit kde-base || die

need-kde 3

LICENSE="GPL-2"
S=${WORKDIR}/${P}
SRC_URI="mirror://sourceforge/qtella/${P}.tar.gz"
HOMEPAGE="http://www.qtella.net"
DESCRIPTION="Excellent KDE Gnutella Client"



