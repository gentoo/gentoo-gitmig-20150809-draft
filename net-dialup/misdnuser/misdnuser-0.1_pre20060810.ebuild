# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/misdnuser/misdnuser-0.1_pre20060810.ebuild,v 1.1 2006/08/11 21:28:16 genstef Exp $

MY_P="mISDNuser-CVS-${PV:7:4}-${PV:11:2}-${PV:13:2}"
DESCRIPTION="mISDN (modular ISDN) kernel link library and includes"
HOMEPAGE="http://www.isdn4linux.de/mISDN"
SRC_URI="ftp://ftp.isdn4linux.de/pub/isdn4linux/CVS-Snapshots/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
S=${WORKDIR}/${MY_P}
RDEPEND=">=net-dialup/misdn-20051228"
#DEPEND="voipisdn? (
#		media-sound/gsm
#		sys-libs/ncurses
#		sys-devel/flex
#	)"

src_unpack() {
	unpack ${A}
	cd ${S}
	#use voipisdn ||
	mv voip voip.disabled
}

src_install() {
	dolib.a lib/libmISDN.a i4lnet/libisdnnet.a tenovis/lib/libtenovis.a

	insinto /usr/include/mISDNuser
	doins include/*.h tenovis/lib/tenovis.h i4lnet/*.h

	dosbin example/loadfirm
	#use voipisdn && dobin voip/voipisdn
}
