# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kickpim/kickpim-0.5.3.ebuild,v 1.2 2004/04/03 14:37:09 aliz Exp $

inherit kde-base || die
need-kde 3

IUSE=""
SLOT="0"

#S=${WORKDIR}/kickpim-${PV}
DESCRIPTION="A KDE panel applet for editing and accessing the KDE Adressbook."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://kickpim.sourceforge.net"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

src_unpack() {
	kde_src_unpack

	epatch ${FILESDIR}/${P}-fPIC.patch
}
