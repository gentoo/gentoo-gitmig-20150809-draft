# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/giftcurs/giftcurs-0.4.1.ebuild,v 1.1 2002/05/31 16:00:48 verwilst Exp $

S="${WORKDIR}/giFTcurs-${PV}"
DESCRIPTION="a cursed frontend to the giFT (OpenFT) daemon"
SRC_URI="mirror://sourceforge/giftcurs/giFTcurs-${PV}.tar.gz"
HOMEPAGE="http://giftcurs.sourceforge.net"
SLOT="0"

DEPENDS="virtual/glibc
	>=sys-libs/ncurses-5.2
	>=net-misc/gift-0.10.0_pre020527"

src_compile() {
	local myconf
	cd ${S}
	use gpm || myconf="${myconf} --disable-mouse --disable-libgpm"
	use nls || myconf="${myconf} --disable-nls" 
	./configure --prefix=/usr --host=${CHOST} ${myconf}
	emake || die
}

src_install() {

	einstall || die

}
