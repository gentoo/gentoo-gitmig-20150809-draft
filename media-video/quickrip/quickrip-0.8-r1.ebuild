# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/quickrip/quickrip-0.8-r1.ebuild,v 1.4 2007/07/12 02:40:43 mr_bones_ Exp $

inherit eutils qt3

S="${WORKDIR}/quickrip"
DESCRIPTION="Basic DVD ripper written in Python with Qt and command line interfaces."
HOMEPAGE="http://quickrip.sourceforge.net/"
SRC_URI="mirror://sourceforge/quickrip/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 -mips -ppc x86"
IUSE=""
DEPEND="virtual/libc
	>=dev-lang/python-2.2
	$(qt_min_version 3.1)
	>=dev-python/PyQt-3.5-r1
	media-video/mplayer
	media-video/transcode"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-sizetype.patch
}

src_install() {
	MANDIR=${D}/usr/share/man/man1
	exeinto /usr/share/quickrip
	doexe *.py ui/*.ui quickriprc
	doman *.1.gz
	dodoc README LICENSE
	dodir /usr/bin
	dosym /usr/share/quickrip/quickrip.py /usr/bin/quickrip
}
