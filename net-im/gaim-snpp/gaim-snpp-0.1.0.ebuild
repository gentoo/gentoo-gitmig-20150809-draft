# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim-snpp/gaim-snpp-0.1.0.ebuild,v 1.1 2004/03/29 22:50:03 rizzo Exp $

use debug && inherit debug

DESCRIPTION="gaim-snpp is an SNPP protocol plug-in for Gaim"
HOMEPAGE="http://gaim-snpp.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug"

DEPEND="~net-im/gaim-0.75"
#RDEPEND=""

#S=${WORKDIR}/${P}

src_compile() {
	local myconf
	myconf="${myconf} --with-gaim=/usr/include/gaim"

	econf ${myconf} || die "econf failure"
	emake || die "emake failure"
}

src_install() {
	make install DESTDIR=${D} || die "install failure"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS PROTOCOL README VERSION
}
