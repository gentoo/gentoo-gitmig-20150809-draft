# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/audacity/audacity-1.0.0-r2.ebuild,v 1.1 2002/08/26 22:14:40 spider Exp $


MY_P="${PN}-src-${PV}"
ID3V="id3lib-3.8.0"

S=${WORKDIR}/${MY_P}
DESCRIPTION="A free, crossplatform audio editor."
SRC_URI="mirror://sourceforge/audacity/${MY_P}.tgz
	mirror://sourceforge/id3lib/${ID3V}.tar.gz"

#the included id3lib breaks and I figure its better to 
# update to stable than to attempt to hack the patch 
# spider // 

HOMEPAGE="http://audacity.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

# doesn't compile with wxGTK-2.3.2
DEPEND="~x11-libs/wxGTK-2.2.9
	oggvorbis? ( media-libs/libvorbis )
	app-arch/zip" 
RDEPEND=${DEPEND}


src_unpack() {
	unpack ${MY_P}.tgz


## id3lib hack
	cd ${WORKDIR}/audacity-src-${PV}
	unpack ${ID3V}.tar.gz
	rm -rf id3lib
	mv ${ID3V} id3lib



	# Only patch if using gcc 3.x
	if [ "`eval echo \`gcc -dumpversion\` | cut -f1 -d.`" -eq 3 ]
	then
		cd ${WORKDIR}/audacity-src-${PV}/id3lib
		# updated patch from id3lib
		pwd
		patch -p0 <${FILESDIR}/${ID3V}-gcc3.patch	||die "foo "

	# patch -p1 <${FILESDIR}/${P}-gcc31.patch || die
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

