# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/media-video/quickrip/quickrip-0.7.ebuild,v 1.1 2003/07/04 07:22:06 brain Exp $

inherit eutils 

S="${WORKDIR}/QuickRip"
DESCRIPTION="Basic DVD ripper written in Python and PyQT."
SRC_URI="mirror://sourceforge/quickrip/${P}.tar.gz"
HOMEPAGE="http://quickrip.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -ppc -mips"
IUSE=""

DEPEND="virtual/glibc
	>=dev-lang/python-2.2
	>=x11-libs/qt-3.1
	>=dev-python/PyQt-3.5-r1
	media-video/mplayer
	media-video/transcode"

src_install() {
	exeinto /usr/share/quickrip

	doexe *.py ui/*.ui quickriprc

	dodoc README LICENSE
	dodir /usr/bin
	dosym /usr/share/quickrip/quickrip.py /usr/bin/quickrip
}
