# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audiocompress/audiocompress-1.5.2.ebuild,v 1.3 2006/11/20 20:40:00 blubb Exp $

IUSE=""

inherit eutils

MY_P="AudioCompress-${PV}"

DESCRIPTION="Very gentle 1-band dynamic range compressor"
HOMEPAGE="http://beesbuzz.biz/code/"
SRC_URI="http://beesbuzz.biz/code/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#-sparc: 1.5.5 - Gdk-ERROR **: BadValue (integer parameter out of range for operation) serial 7 error_code 2 request_code 1 minor_code 0
KEYWORDS="~amd64 ~ppc -sparc x86"

DEPEND="media-sound/esound"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	cd ${S}
	make clean

	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	emake AudioCompress || die
}

src_install() {
	dobin AudioCompress || die
	dodoc ChangeLog README TODO
}
