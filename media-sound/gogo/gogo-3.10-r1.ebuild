# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gogo/gogo-3.10-r1.ebuild,v 1.8 2003/09/07 00:06:05 msterret Exp $

MY_PV=310pl3
DESCRIPTION="GoGo is an assembly optimized version of LAME 3.91"
HOMEPAGE="http://member.nifty.ne.jp/~pen/free/gogo3/mct_gogo.htm"
SRC_URI="http://member.nifty.ne.jp/~pen/free/gogo3/down/petit${MY_PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc -sparc"

DEPEND="dev-lang/nasm"
#	>=sys-libs/ncurses-5.H2
#	gtk?    ( =x11-libs/gtk+-1.2* )"
#	oggvorbis? ( >=media-libs/libvorbis-1.0_rc3 )"
# Oggvorbis support breaks with -rc3
#RDEPEND="virtual/glibc"
#	>=sys-libs/ncurses-5.2
#	gtk?    ( =x11-libs/gtk+-1.2* )"
#	oggvorbis? ( >=media-libs/libvorbis-1.0_rc3 )"

S=${WORKDIR}/petit${MY_PV}

src_compile() {
	local myconf=""
#	if [ "`use oggvorbis`" ] ; then
#		myconf="--with-vorbis"
		myconf="--without-vorbis"
#	else
#		myconf="--without-vorbis"
#	fi
#	if [ "`use gtk`" ] ; then
#		myconf="$myconf --enable-mp3x"
#	fi
	[ `use debug` ] \
		&& myconf="$myconf --enable-debug=yes" \
		|| myconf="$myconf --enable-debug=no"

	econf \
		--enable-shared \
		--enable-nasm \
		--enable-extopt=full \
		$myconf || die

	emake || die
}

src_install () {
	epatch ${FILESDIR}/make-work-3.10pl3.patch

	dodir /usr/bin
	dodir /usr/share/man
	dodir /usr/share/doc

	make exec_prefix=${D}usr \
		mandir=${D}usr/share/man \
		install || die

	dodoc  COPYING readme_e.txt
	dohtml -r ./
}
