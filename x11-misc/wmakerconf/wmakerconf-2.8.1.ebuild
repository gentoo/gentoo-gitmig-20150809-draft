# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmakerconf/wmakerconf-2.8.1.ebuild,v 1.4 2002/07/11 06:30:57 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="X based config tool for the windowmaker X windowmanager."
SRC_URI="http://wmaker.orcon.net.nz/current/${P}.tar.gz"
HOMEPAGE="http://ulli.on.openave.net/wmakerconf/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/glibc
	>=x11-base/xfree-4.1.0
	x11-wm/WindowMaker 
	x11-libs/libPropList"

RDEPEND="${DEPEND}"

src_compile() {

        local myconf
	use ipv6 && myconf="${myconf} --enable-ipv6"
        ./configure --prefix=/usr --host=${CHOST} ${myconf} || die
	emake || die

}

src_install() {

        make prefix=${D}/usr install || die

        dodoc README MANUAL AUTHORS TODO THANKS BUGS NEW COPYING ChangeLog
}



