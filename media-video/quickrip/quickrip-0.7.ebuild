# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/quickrip/quickrip-0.7.ebuild,v 1.7 2005/02/22 20:59:49 carlo Exp $

inherit eutils

S="${WORKDIR}/QuickRip"
DESCRIPTION="Basic DVD ripper written in Python and PyQT."
HOMEPAGE="http://quickrip.sourceforge.net/"
SRC_URI="mirror://sourceforge/quickrip/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc -mips"
IUSE=""

DEPEND="virtual/libc
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
