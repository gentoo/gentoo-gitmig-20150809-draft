# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/wine-doc/wine-doc-20020710.ebuild,v 1.1 2002/07/29 17:42:33 phoenix Exp $

S=${WORKDIR}/wine-$PV
DESCRIPTION="Wine is a free implementation of Windows on Unix."
SRC_URI="ftp://metalab.unc.edu/pub/Linux/ALPHA/wine/development/Wine-${PV}.tar.gz"
HOMEPAGE="http://www.winehq.com/"
LICENSE="LPGL-2.1"
SLOT="0"
KEYWORDS="x86"

DEPEND=""

src_compile() {
	
	cd ${S}
	local myconf

	use opengl && myconf="--enable-opengl" || myconf="--disable-opengl"
	[ -z $DEBUG ] && myconf="$myconf --disable-trace --disable-debug" || myconf="$myconf --enable-trace --enable-debug"
	# there's no configure flag for cups, it's supposed to be autodetected
	
	# the folks at #winehq were really angry about custom optimization
	export CFLAGS=""
	export CXXFLAGS=""
	
	./configure --prefix=/usr \
	--exec_prefix=/usr/wine \
	--sysconfdir=/etc/wine \
	--mandir=/usr/share/man \
	--host=${CHOST} \
	--enable-curses \
	${myconf} || die

	cd ${S}/programs/winetest
	cp Makefile 1
	sed -e 's:wine.pm:include/wine.pm:' 1 > Makefile
	
	cd ${S}	
	make manpages || die
	
}

src_install () {

	cd ${S}/documentation
	DESTTREE=/usr/wine doman man3w/*
	# sgml was being filtered without -a sgml
	dohtml -a sgml *.sgml
	
	insinto /etc/env.d
	doins ${FILESDIR}/80wine-doc
}

