# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vlms/vlms-0.2.2.ebuild,v 1.8 2005/03/28 00:13:18 chriswhite Exp $

inherit eutils

DESCRIPTION="The VideoLAN mini-server"
HOMEPAGE="http://www.videolan.org/vlms/"
SRC_URI="http://www.videolan.org/pub/videolan/vlms/0.2.2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc -sparc "
IUSE=""

DEPEND=">=media-libs/libdvdread-0.9.3
	>=media-libs/libdvdcss-1.2.1
	>=media-libs/libdvbpsi-0.1.1"
#RDEPEND=""

src_unpack() {

	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PV}-vlf-cr-fix.patch

}

src_compile() {

	make prefix=/usr || die "emake failed"

}

src_install () {

	dodir /usr/bin
	make prefix=${D}/usr install || die "einstall failed"
	dobin vlf

}
