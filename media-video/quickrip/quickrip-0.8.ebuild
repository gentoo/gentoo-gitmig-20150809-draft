# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/quickrip/quickrip-0.8.ebuild,v 1.6 2004/08/20 21:13:00 pythonhead Exp $

inherit eutils

S="${WORKDIR}/quickrip"
DESCRIPTION="Basic DVD ripper written in Python with Qt and command line interfaces."
HOMEPAGE="http://quickrip.sourceforge.net/"
SRC_URI="mirror://sourceforge/quickrip/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc -mips ~amd64"
IUSE=""
DEPEND="virtual/libc
	>=dev-lang/python-2.2
	>=x11-libs/qt-3.1
	>=dev-python/PyQt-3.5-r1
	media-video/mplayer
	media-video/transcode"

src_install() {
	MANDIR=${D}/usr/share/man/man1
	exeinto /usr/share/quickrip
	doexe *.py ui/*.ui quickriprc
	doman *.1.gz
	dodoc README LICENSE
	dodir /usr/bin
	dosym /usr/share/quickrip/quickrip.py /usr/bin/quickrip
}

