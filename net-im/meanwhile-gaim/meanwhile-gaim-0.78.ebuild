# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/meanwhile-gaim/meanwhile-gaim-0.78.ebuild,v 1.2 2004/06/08 12:36:04 dholm Exp $

inherit flag-o-matic eutils
use debug && inherit debug

LIB_PN="meanwhile"
DESCRIPTION="GAIM Meanwhile (Sametime protocol) Plugin"
HOMEPAGE="http://meanwhile.sourceforge.net/"
SRC_URI="mirror://sourceforge/${LIB_PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
DEPEND="~net-libs/meanwhile-0.2
	~net-im/gaim-${PV}"
IUSE=""

src_compile() {
	local myconf
	myconf="--with-gaim-source=/usr/include/gaim/src"
	econf ${myconf} || die "Configuration failed"
	emake || die "Make failed"
}

src_install() {
	make install DESTDIR=${D} || die "Install failed"
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README
}

