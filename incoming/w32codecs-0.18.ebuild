# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@saintmail.net>

S=${WORKDIR}
DESCRIPTION="Win32 binary codecs for MPlayer and maybe avifile as well."
SRC_URI="ftp://ftp.mplayerhq.hu/MPlayer/releases/w32codec.zip"
HOMEPAGE="http://www.mplayerhq.hu/"

DEPEND=""

src_install () {
	cd ${S}
	
	dodir /usr/lib/win32
	cp ${S}/* ${D}/usr/lib/win32
}

