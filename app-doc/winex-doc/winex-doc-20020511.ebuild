# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Maintainer Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/winex-doc/winex-doc-20020511.ebuild,v 1.1 2002/06/14 16:30:32 danarmak Exp $

S=${WORKDIR}/wine
DESCRIPTION="WineX is a distribution of Wine with enhanced DirectX for gaming"
SRC_URI="ftp:/www.ibiblio.org/gentoo/distfiles/winex-$PV.tar.bz2"
HOMEPAGE="http://www.transgaming.com/"

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
	--exec_prefix=/usr/winex \
	--sysconfdir=/etc/winex \
	--mandir=/usr/winex/man \
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
	DESTTREE=/usr/winex doman man3w/*
	# sgml was being filtered without -a sgml
	dohtml -a sgml *.sgml
	
	insinto /etc/env.d
	doins ${FILESDIR}/81winex-doc
	
}

