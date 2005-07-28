# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/apollo/apollo-1.4.1.ebuild,v 1.9 2005/07/28 20:56:30 caleb Exp $

IUSE="kde qt"

S=${WORKDIR}/${P}-1
DESCRIPTION="A Qt-based front-end to mpg123"
SRC_URI="mirror://sourceforge/apolloplayer/apollo-src-1.4.1-1.tar.bz2"
HOMEPAGE="http://www.apolloplayer.org"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/mpg123
	media-libs/id3lib
	media-sound/madplay
	qt?	( =x11-libs/qt-3* )
	kde?	( =kde-base/kdelibs-3* )"
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
	myconf="--without-kde --without-stl"
#	use kde && kdeconf="--with-kde=$KDEDIR" || kdeconf="--without-kde"
#kde support currently does not work
#	myconf="$myconf $kdeconf"
	use qt && myconf="$myconf --with-qt-dir=$QTDIR --with-qmake" || myconf="$myconf --with-tmake"
#	use stl && myconf="$myconf --with-stl" || myconf="$myconf --without-stl"
#stl support is broken
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
