# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim-snpp/gaim-snpp-0.1.0_beta.ebuild,v 1.2 2004/03/26 03:18:55 rizzo Exp $

MY_PV=${PV/_/-}
DESCRIPTION="gaim-snpp is an SNPP protocol plug-in for Gaim"
HOMEPAGE="http://gaim-snpp.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug"

DEPEND="~net-im/gaim-0.75"
#RDEPEND=""

S=${WORKDIR}/${PN}-${MY_PV}

src_compile() {
	local myconf
	myconf=`use_enable debug`
	myconf="${myconf} --with-gaim=/usr/include/gaim"

	econf ${myconf} || die "econf failure"
	emake || die "emake failure"
}

src_install() {
	einstall || die "einstall failure"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS PROTOCOL README VERSION
}
