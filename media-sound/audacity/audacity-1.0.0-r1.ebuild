# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/audacity/audacity-1.0.0-r1.ebuild,v 1.1 2002/08/09 18:45:44 raker Exp $

DESCRIPTION="A free, crossplatform audio editor."
SRC_URI="mirror://sourceforge/audacity/audacity-src-1.0.0.tgz"
HOMEPAGE="http://audacity.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

# doesn't compile with wxGTK-2.3.2
DEPEND="~x11-libs/wxGTK-2.2.9
	oggvorbis? ( media-libs/libvorbis )" 

src_unpack() {

	unpack ${A}

	# Only patch if using gcc 3.x
	if [ "`eval echo \`gcc -dumpversion\` | cut -f1 -d.`" -eq 3 ]
	then
		cd ${WORKDIR}/audacity-src-${PV}
		patch -p1 <${FILESDIR}/${P}-gcc31.patch || die
	fi
}

src_compile() {
	local myconf
	myconf="--with-id3"
	use oggvorbis && myconf="${myconf} --with-vorbis"

	# arts is broken! :(
	# use arts && myconf="${myconf} --with-arts-soundserver"
	
	cd ${WORKDIR}/audacity-src-1.0.0
	./configure --prefix=/usr $myconf || die

	make || die
}

src_install () {
	cd ${WORKDIR}/audacity-src-1.0.0
	
	export PREFIX=${D}/usr
	make -e install || die
}

