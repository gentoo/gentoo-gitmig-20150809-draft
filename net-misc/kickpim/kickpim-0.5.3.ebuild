# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kickpim/kickpim-0.5.3.ebuild,v 1.1 2004/03/10 21:05:40 centic Exp $

inherit kde-base || die
need-kde 3

IUSE=""
SLOT="0"

#S=${WORKDIR}/kickpim-${PV}
DESCRIPTION="A KDE panel applet for editing and accessing the KDE Adressbook."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://kickpim.sourceforge.net"

LICENSE="GPL-2"
KEYWORDS="~x86"

