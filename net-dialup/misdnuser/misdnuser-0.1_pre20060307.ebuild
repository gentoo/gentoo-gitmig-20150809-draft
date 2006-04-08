# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/misdnuser/misdnuser-0.1_pre20060307.ebuild,v 1.1 2006/04/08 17:32:00 genstef Exp $

inherit flag-o-matic eutils cvs

MY_P="mISDNuser"
DESCRIPTION="mISDN (modular ISDN) kernel link library and includes"
HOMEPAGE="http://www.isdn4linux.de/mISDN"
SRC_URI=""
ECVS_SERVER="cvs.isdn4linux.de:/i4ldev"
ECVS_MODULE="${MY_P}"
ECVS_PASS="readonly"
ECVS_CO_OPTS="-D ${PV#*_pre}"
ECVS_UP_OPTS="-dP ${ECVS_CO_OPTS}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
S=${WORKDIR}/${MY_P}
RDEPEND=">=net-dialup/misdn-20051228"
#DEPEND="voipisdn? ( media-sound/gsm
#	sys-libs/ncurses
#	sys-devel/flex )"

src_unpack() {
	cvs_src_unpack
	cd ${S}
#	use voipisdn || 
	mv voip voip.disabled
}

src_compile() {
	append-flags -fPIC
	emake || die "emake failed"
}

src_install() {
	dolib.a lib/libmISDN.a i4lnet/libisdnnet.a tenovis/lib/libtenovis.a

	insinto /usr/include/mISDNuser
	doins include/*.h tenovis/lib/tenovis.h i4lnet/*.h

	dosbin example/loadfirm
#	use voipisdn && dobin voip/voipisdn
}
