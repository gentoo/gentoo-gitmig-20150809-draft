# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpeg/ffmpeg-0.4.5.ebuild,v 1.7 2002/09/26 11:53:37 aliz Exp $

S=${WORKDIR}/ffmpeg
DESCRIPTION="Tool to manipulate and stream video files"
SRC_URI="mirror://sourceforge/ffmpeg/${P}.tar.gz"
HOMEPAGE="http://ffmpeg.sourceforge.net/"

inherit flag-o-matic
filter-flags -fforce-addr

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc -sparc64"

DEPEND="dev-lang/nasm"

src_compile() {
	local myconf

	use mmx || myconf="--disable-mmx"

	./configure ${myconf} || die
	make || die
}

src_install() {
	dobin ffmpeg ffserver
	dodoc doc/*
}
