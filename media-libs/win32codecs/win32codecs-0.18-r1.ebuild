# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@gentoo.org>, Donny Davies <woodchip@gentoo.org>

S=${WORKDIR}
DESCRIPTION="Win32 binary codecs for MPlayer and maybe avifile as well"
SRC_URI="ftp://ftp.mplayerhq.hu/MPlayer/releases/w32codec.zip
	 ftp://ftp.mplayerhq.hu/MPlayer/releases/divx.dll"
HOMEPAGE="http://www.mplayerhq.hu/"

DEPEND=""


src_unpack() {

	unpack w32codec.zip

}

src_install() {

	insinto /usr/lib/win32 ; doins ${S}/*

	# Install the new divx codec
	insinto /usr/lib/win32
	doins /usr/portage/distfiles/divx.dll
	
}
