# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/apollo/apollo-1.4.1.ebuild,v 1.2 2002/10/05 05:39:16 drobbins Exp $

IUSE="kde qt"

#inherit kde-base
#use kde && inherit kde-base
#need-kde 3

S=${WORKDIR}/${P}-1
DESCRIPTION="A Qt-based front-end to mpg123"
SRC_URI="mirror://sourceforge/apolloplayer/apollo-src-1.4.1-1.tar.bz2"
HOMEPAGE="http://www.apolloplayer.org"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="media-sound/mpg123
	media-libs/id3lib
	media-sound/mad
	qt?		( x11-libs/qt )
	kde?	( kde-base/kdelibs )"
#	dev-libs/STLport

src_unpack() {
	cd ${WORKDIR}
	unpack ${A}
	cd ${S}
	bzip2 -dc ${FILESDIR}/${P}.patch.bz2 | patch || die "Patch failed"
	mv install.sh install.sh.orig
	sed -e 's:$PREFIX/local:$PREFIX:g' -e 's:BINDIR=$dir::' \
		install.sh.orig > install.sh
}

src_compile() {
	local myconf
	myconf="--without-kde"
#	use kde && kdeconf="--with-kde=$KDEDIR" || kdeconf="--without-kde"
	myconf="$myconf $kdeconf"
	use qt && myconf="$myconf --with-qt-dir=$QTDIR --with-qmake" || myconf="$myconf --with-tmake"
#	use stl && myconf="$myconf --with-stl" || myconf="$myconf --without-stl"
#	use buffer && myconf="$myconf --enable-buffer" || myconf="$myconf --disable-buffer"
#	use mad && myconf="$myconf --with-mad=/usr/lib"
	myconf="$myconf --with-mad=/usr/lib"
	./configure.sh $myconf
	gmake || die "Make failed"
}

src_install () {
	dodir /usr/bin
	sh install.sh --prefix=${D}/usr $kdeconf
}
