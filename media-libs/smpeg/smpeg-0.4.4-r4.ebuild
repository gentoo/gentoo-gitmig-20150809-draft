# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/smpeg/smpeg-0.4.4-r4.ebuild,v 1.11 2004/01/29 07:43:01 vapier Exp $

DESCRIPTION="SDL MPEG Player Library"
HOMEPAGE="http://www.lokigames.com/development/smpeg.php3"
SRC_URI="ftp://ftp.lokigames.com/pub/open-source/smpeg/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64"
IUSE="X gtk opengl"

DEPEND=">=media-libs/libsdl-1.2.0
	opengl? ( virtual/opengl virtual/glu )
	gtk? ( =x11-libs/gtk+-1.2* )"

src_unpack() {
	unpack ${P}.tar.gz

	## GCC 3.1 fix from bug #5558 (cardoe 08/03/02)
	cd ${S}
	if [ `gcc -dumpversion | cut -d"." -f1` == "3" ] ; then
		patch -p1 < ${FILESDIR}/${P}-gcc-3.1.patch || die
	fi
}

src_compile() {
	local myconf
# --enable-mmx causes test apps to crash on startup .. smpeg bug?
# bugzilla bug #470 -- azarah (03/02/2002)
#	if [ "`use mmx`" ] ; then
#		myconf="--enable-mmx"
#	fi
	if [ -z "`use gtk`" ] ; then
		myconf="${myconf} --disable-gtk-player"
	fi
	if [ -z "`use X`" ] ; then
		myconf="${myconf} --disable-gtk-player --without-x"
	fi
	if [ -z "`use opengl`" ] ; then
		myconf="${myconf} --disable-opengl-player"
	fi

	export CC=g++
	export CXX=g++

	econf ${myconf} || die "configure failed"

	emake || die "parallel make failed"
}

src_install() {
	einstall || die "make install failed"
	dodoc CHANGES README* TODO
}
