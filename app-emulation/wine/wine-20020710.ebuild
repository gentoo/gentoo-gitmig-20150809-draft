# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/wine/wine-20020710.ebuild,v 1.3 2002/07/22 00:11:24 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Wine is a free implementation of Windows on Unix."
SRC_URI="ftp://metalab.unc.edu/pub/Linux/ALPHA/wine/development/Wine-${PV}.tar.gz"
HOMEPAGE="http://www.winehq.com/"

DEPEND="virtual/glibc
	virtual/x11
	sys-devel/gcc
	sys-devel/flex
	dev-util/yacc
	opengl? ( virtual/opengl )
	>=sys-libs/ncurses-5.2
	cups? ( net-print/cups )
	>=media-libs/freetype-2.0.0
	dev-lang/tcl dev-lang/tk"

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
	make depend all || die
	cd programs && emake || die
	
}

src_install () {

	local WINEMAKEOPTS="prefix=${D}/usr \
		mandir=${D}/usr/wine/man \
		includedir=${D}/usr/wine/include \
		exec_prefix=${D}/usr/wine"
	
	cd ${S}
	make ${WINEMAKEOPTS} install || die
	cd ${S}/programs
	make ${WINEMAKEOPTS} install || die
	
	# these .so's are strange. they are from the make in programs/ above,
	# and are for apps built with winelib (windows sources built directly
	# against wine). Apparently the sources go into a <program name>.so file
	# and you run it via a symlink <program name> -> wine. Unfortunately both
	# the symlink and the .so apparently must reside in /usr/bin.
	cd ${D}/usr/wine/bin
	chmod a-x *.so
		
	cd ${S}
	dodoc ANNOUNCE AUTHORS BUGS ChangeLog DEVELOPERS-HINTS LICENSE README
	
	insinto /etc/wine
	doins documentation/samples/*
	doins ${S}/winedefault.reg
	
	dodir /etc/skel/.wine
	dosym /etc/wine/config /etc/skel/.wine/config
	
	insinto /etc/env.d
	doins ${FILESDIR}/80wine
}

pkg_postinst() {

	einfo "If you are installing wine for the first time,
copy /etc/wine/config (global configuration) to ~/.wine/config
and edit that for per-user configuration. Otherwise, wine will
not run.
Also, run \"regapi setValue < /etc/wine/winedefault.reg\" to setup
per-user registry for using wine. More info in /usr/share/doc/wine-${PV}."

}

