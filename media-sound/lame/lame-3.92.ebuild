# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lame/lame-3.92.ebuild,v 1.22 2004/07/28 17:04:09 agriffis Exp $

inherit libtool

DESCRIPTION="LAME Ain't an MP3 Encoder"
HOMEPAGE="http://www.mp3dev.org/mp3/"
SRC_URI="mirror://sourceforge/lame/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE="gtk debug" #oggvorbis

DEPEND="virtual/libc
	x86? ( dev-lang/nasm )
	>=sys-libs/ncurses-5.2
	gtk? ( =x11-libs/gtk+-1.2* )"
#	oggvorbis? ( >=media-libs/libvorbis-1.0_rc3 )"
# Oggvorbis support breaks with -rc3
RDEPEND="virtual/libc
	>=sys-libs/ncurses-5.2
	gtk? ( =x11-libs/gtk+-1.2* )"
#	oggvorbis? ( >=media-libs/libvorbis-1.0_rc3 )"

src_compile() {
	elibtoolize

	local myconf=""
#	if use oggvorbis ; then
#		myconf="${myconf} --with-vorbis"
#		myconf="${myconf} --without-vorbis"
#	else
		myconf="${myconf} --without-vorbis"
#	fi
	if use gtk ; then
		myconf="${myconf} --enable-mp3x"
	fi
	use debug \
		&& myconf="${myconf} --enable-debug=yes" \
		|| myconf="${myconf} --enable-debug=no"

	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--enable-shared \
		--enable-nasm \
		--enable-mp3rtp \
		--enable-extopt=full \
		${myconf} || die

	emake || die
}

src_install() {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		pkghtmldir=${D}/usr/share/doc/${PF}/html \
		install || die

	dodoc API COPYING HACKING PRESETS.draft LICENSE README* TODO USAGE
	dohtml misc/lameGUI.html Dll/LameDLLInterface.htm
}
