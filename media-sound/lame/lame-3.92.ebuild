# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/lame/lame-3.92.ebuild,v 1.5 2002/08/07 18:11:01 gerk Exp $

S=${WORKDIR}/lame-${PV}
DESCRIPTION="LAME Ain't an Mp3 Encoder"
SRC_URI="http://download.sourceforge.net/lame/${P}.tar.gz"
HOMEPAGE="http://www.mp3dev.org/mp3/"

DEPEND="virtual/glibc
	x86? ( dev-lang/nasm )
	>=sys-libs/ncurses-5.2
	gtk?    ( =x11-libs/gtk+-1.2* )"
#	oggvorbis? ( >=media-libs/libvorbis-1.0_rc3 )"
# Oggvorbis support breaks with -rc3 
RDEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	gtk?    ( =x11-libs/gtk+-1.2* )"
#	oggvorbis? ( >=media-libs/libvorbis-1.0_rc3 )"


SLOT="0"
LICENSE="GPL"
KEYWORDS="x86 ppc"

src_unpack() {
	unpack ${A}
#	cd ${S}
#	patch -p1 < ${FILESDIR}/lame-3.91-gcc3.diff || die
}

src_compile() {

	local myconf=""
	if [ "`use oggvorbis`" ] ; then
#		myconf="--with-vorbis"
		myconf="--without-vorbis"
	else
		myconf="--without-vorbis"
	fi
	if [ "`use gtk`" ] ; then
		myconf="$myconf --enable-mp3x"
	fi
	if [ "$DEBUG" ] ; then
		myconf="$myconf --enable-debug=yes"
	else
		myconf="$myconf --enable-debug=no"
	fi
	
	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--enable-shared \
		--enable-nasm \
		--enable-mp3rtp \
		--enable-extopt=full \
		$myconf || die
		
	emake || die
}

src_install () {

	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		pkghtmldir=${D}/usr/share/doc/${PF}/html \
		install || die

	dodoc API COPYING HACKING PRESETS.draft LICENSE README* TODO USAGE
	dohtml -r ./
}

