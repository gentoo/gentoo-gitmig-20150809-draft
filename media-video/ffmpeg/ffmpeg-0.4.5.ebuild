# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpeg/ffmpeg-0.4.5.ebuild,v 1.3 2002/07/11 06:30:42 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/ffmpeg
DESCRIPTION="Tool to manipulate and stream video files"
SRC_URI="mirror://sourceforge/ffmpeg/${A}"

DEPEND="virtual/glibc"

RDEPEND="virtual/glibc"

src_compile() {

	local myconf

	if [ -z "`use mmx`" ] ; then
		myconf="--disable-mmx"
	fi

	try ./configure ${myconf}
	try make
}

src_install() {

	dobin ffmpeg ffserver
	dodoc doc/*

}
