# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/audacity/audacity-1.0.0.ebuild,v 1.4 2002/07/13 17:06:18 drobbins Exp $

DESCRIPTION="A free, crossplatform audio editor."
SRC_URI="mirror://sourceforge/audacity/audacity-src-1.0.0.tgz"
HOMEPAGE="http://audacity.sourceforge.net/"
LICENSE="GPL-2"

# doesn't compile with wxGTK-2.3.2
DEPEND="virtual/glibc =x11-libs/wxGTK-2.2.9 oggvorbis? ( media-libs/libvorbis )" 
RDEPEND="virtual/glibc =x11-libs/wxGTK-2.2.9 oggvorbis? ( media-libs/libvorbis )"

src_compile() {
	local myconf
	myconf="--with-id3"
	use oggvorbis && myconf="${myconf} --with-vorbis"

	# arts is broken! :(
	# use arts && myconf="${myconf} --with-arts-soundserver"
	
	cd ${WORKDIR}/audacity-src-1.0.0
	./configure --prefix=/usr $myconf || die

	emake || die
}

src_install () {
	cd ${WORKDIR}/audacity-src-1.0.0
	
	export PREFIX=${D}/usr
	make -e install || die
}

