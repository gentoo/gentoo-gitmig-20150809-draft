# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/audacity/audacity-1.1.0.ebuild,v 1.2 2002/08/27 22:52:46 agenkin Exp $

DESCRIPTION="A free, crossplatform audio editor."
HOMEPAGE="http://audacity.sourceforge.net/"
LICENSE="GPL-2"

# doesn't compile with wxGTK-2.3.2
DEPEND="~x11-libs/wxGTK-2.2.9
	oggvorbis? ( media-libs/libvorbis )
	app-arch/zip
	media-sound/mad
	media-libs/libsndfile"
	
RDEPEND="${DEPEND}"

SLOT="0"
KEYWORDS="x86"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.tgz"
S="${WORKDIR}/${PN}-src-${PV}"

src_unpack() {
	unpack "${PN}-src-${PV}.tgz"
	## Patches from http://www.hcsw.org/audacity/
	patch -p0 < "${FILESDIR}/${PN}-src-${PV}-timestretch.patch" || die
	patch -p0 < "${FILESDIR}/${PN}-src-${PV}-phonograph.patch" || die
}

src_compile() {
	local myconf
	
	myconf="--with-id3tag --with-libmad"
	# vorbis breaks 4 me (rigo@home.nl)
	# use oggvorbis && myconf="${myconf} --without-vorbis"
	myconf="${myconf} --without-vorbis"

	use arts && myconf="${myconf} --with-arts-soundserver"
	
	./configure --prefix=/usr $myconf || die
	make || die
}

src_install () {
	make PREFIX="${D}/usr" install || die
	dodoc LICENSE.txt README.txt
}
