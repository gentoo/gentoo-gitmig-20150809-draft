# Copyright 1999-2003 Gentoo Technologies, Inc. 
# Distributed under the terms of the GNU General Public License v2 

inherit eutils 

MY_PV="$(echo ${PV} | cut -d. -f1,2)" 
S="${WORKDIR}/QuickRip"
DESCRIPTION="Basic DVD ripper written in Python and PyQT." 
SRC_URI="http://www.tomchance.uklinux.net/projects/${P}.tar.gz"
HOMEPAGE="http://www.tomchance.uklinux.net/projects/quickrip.shtml" 

LICENSE="GPL-2" 
SLOT="0" 
KEYWORDS="~x86 -ppc -mips"
IUSE=""

DEPEND="virtual/glibc 
	>=dev-lang/python-2.2 
	>=x11-libs/qt-3.1 
	>=dev-python/PyQt-3.5 
	media-video/mplayer 
	media-video/transcode" 

src_install() { 
	exeinto /usr/share/quickrip 
	doexe *.py ui/*.ui

	dodoc README LICENSE
	dodir /usr/bin
	dosym /usr/share/quickrip/quickrip.py /usr/bin/quickrip 
}
