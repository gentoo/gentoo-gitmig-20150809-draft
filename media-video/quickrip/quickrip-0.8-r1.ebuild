# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/quickrip/quickrip-0.8-r1.ebuild,v 1.7 2009/09/23 14:34:08 ssuominen Exp $

EAPI=1

inherit eutils qt3

S=${WORKDIR}/quickrip

DESCRIPTION="Basic DVD ripper written in Python with Qt and command line interfaces."
HOMEPAGE="http://quickrip.sourceforge.net/"
SRC_URI="mirror://sourceforge/quickrip/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 -mips -ppc x86"
IUSE=""

DEPEND="dev-lang/python
	x11-libs/qt:3
	>=dev-python/PyQt-3.5-r1
	media-video/mplayer
	media-video/transcode"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-sizetype.patch"
}

src_install() {
	MANDIR="${D}"/usr/share/man/man1
	exeinto /usr/share/quickrip
	doexe *.py ui/*.ui quickriprc
	doman *.1.gz
	dodoc README
	dodir /usr/bin
	dosym /usr/share/quickrip/quickrip.py /usr/bin/quickrip
}
