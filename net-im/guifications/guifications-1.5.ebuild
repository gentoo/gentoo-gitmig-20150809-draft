# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/guifications/guifications-1.5.ebuild,v 1.1 2004/02/18 18:32:05 rizzo Exp $

DESCRIPTION="Guifications are graphical notification plugin for the open source instant message client gaim"
HOMEPAGE="http://guifications.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=net-im/gaim-0.75-r8"
#RDEPEND=""

#S=${WORKDIR}/${P}

src_compile() {
	local myconf
	myconf="--with-gaim=/usr/include/gaim"

	econf ${myconf} || die "econf failure"
	emake || die "emake failure"
	#make || die
}

src_install() {
	einstall || die "einstall failure"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO VERSION
}
