# Copyright 1999-2002 Gentoo Technologies, Inc. 
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/net-misc/qtella/qtella-0.5.3.ebuild,v 1.1 2002/06/25 10:24:39 verwilst Exp $

inherit kde-base || die

need-kde 3

S=${WORKDIR}/${P}
SRC_URI="mirror://sourceforge/qtella/${P}.tar.gz"
HOMEPAGE="http://www.qtella.net"
DESCRIPTION="Excellent KDE Gnutella Client"



