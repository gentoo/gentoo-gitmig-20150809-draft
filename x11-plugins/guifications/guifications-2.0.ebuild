# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/guifications/guifications-2.0.ebuild,v 1.4 2004/09/02 18:22:39 pvdabeel Exp $

DESCRIPTION="Guifications are graphical notification plugin for the open source instant message client gaim"
HOMEPAGE="http://guifications.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ppc ~sparc"
IUSE="debug"

DEPEND="~net-im/gaim-0.81"
#RDEPEND=""

src_compile() {
	local myconf
	myconf=`use_enable debug`

	econf ${myconf} || die "econf failure"
	emake || die "emake failure"
}

src_install() {
	make install DESTDIR=${D} || die "make install failure"
	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README TODO VERSION
}
