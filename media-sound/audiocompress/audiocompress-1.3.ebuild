# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audiocompress/audiocompress-1.3.ebuild,v 1.2 2003/06/05 01:26:46 robh Exp $

MY_P="AudioCompress-${PV}"

DESCRIPTION="AudioCompress is (essentially) a very gentle, 1-band dynamic range compressor intended to keep audio output at a consistent volume without introducing any audible artifacts."
SRC_URI="http://trikuare.cx/code/${MY_P}.tar.gz"
HOMEPAGE="http://trikuare.cx/code/AudioCompress.html"
IUSE="xmms"

S=${WORKDIR}/${MY_P}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="xmms? ( media-sound/xmms )"

src_compile() {
	if [ -n "`use xmms`" ]; then
	  emake || die
	else
	  emake AudioCompress
	fi
}

src_install() {
    dodir /usr/bin
	install -m 755 AudioCompress ${D}/usr/bin/ || die
	if [ -n "`use xmms`" ]; then
	  installdir="${D}$(xmms-config --effect-plugin-dir)"
	  install -d ${installdir} || die
	  install -m 755 libcompress.so ${installdir} || die
	fi
	dodoc COPYING ChangeLog README TODO
}
