# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/smpeg/smpeg-0.4.4-r2.ebuild,v 1.13 2004/03/19 07:56:05 mr_bones_ Exp $

IUSE="X gtk opengl"

S=${WORKDIR}/${P}
DESCRIPTION="SDL MPEG Player Library"
SRC_URI="ftp://ftp.lokigames.com/pub/open-source/smpeg/${P}.tar.gz"
HOMEPAGE="http://www.lokigames.com/development/smpeg.php3"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND=">=media-libs/libsdl-1.2.0
	opengl? ( virtual/opengl virtual/glu )
	gtk? ( =x11-libs/gtk+-1.2* )"

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

	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		${myconf} || die

	emake CCLD="g++" || die
}

src_install () {

	make DESTDIR=${D} install || die

	dodoc CHANGES COPYING README* TODO
}

