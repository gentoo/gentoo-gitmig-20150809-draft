# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/lcd4linux/lcd4linux-0.98-r1.ebuild,v 1.3 2002/07/25 19:18:34 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="system and ISDN information is shown on an external display or in a X11 window."
SRC_URI="http://download.sourceforge.net/lcd4linux/${P}.tar.gz"
HOMEPAGE="http://lcd4linux.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="png? ( media-libs/libpng
	sys-libs/zlib
	media-libs/libgd )"

src_compile() {

	local myconf
	
	use png || myconf=",!PNG"
	use pda || myconf="${myconf},!PalmPilot"

	econf \
		--sysconfdir=/etc/lcd4linux \
		--with-drivers="all${myconf}" || die
		
	emake || die

}

src_install () {

	einstall || die

	insinto /etc/lcd4linux
	cp lcd4linux.conf.sample lcd4linux.conf 
	insopts -o root -g root -m 0600
	doins lcd4linux.conf
	dodoc README* NEWS COPYING INSTALL TODO CREDITS FAQ
	dodoc lcd4linux.conf.sample lcd4linux.kdelnk lcd4linux.xpm

	use kde && ( \
		insinto /etc/lcd4linux
		insopts -o root -g root -m 0600
		doins lcd4kde.conf
		insinto ${KDEDIR}/share/applnk/apps/System
		doins lcd4linux.kdelnk 
		insinto ${KDEDIR}/share/icons
		doins lcd4linux.xpm 
		touch /etc/lcd4linux/lcd4X11.conf 
	)
}
