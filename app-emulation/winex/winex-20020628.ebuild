# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/winex/winex-20020628.ebuild,v 1.3 2002/07/21 03:02:24 cardoe Exp $

S=${WORKDIR}/wine
DESCRIPTION="WineX is a distribution of Wine with enhanced DirectX for gaming"
SRC_URI="ftp:/www.ibiblio.org/gentoo/distfiles/${P}.tar.bz2"
HOMEPAGE="http://www.transgaming.com/"

DEPEND="virtual/x11
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
	make depend all || die
	cd programs && emake || die
	
}

src_install () {

	local WINEXMAKEOPTS="prefix=${D}/usr \
		mandir=${D}/usr/winex/man \
		includedir=${D}/usr/winex/include \
		exec_prefix=${D}/usr/winex"
	
	cd ${S}
	make ${WINEXMAKEOPTS} install || die
	cd ${S}/programs
	make ${WINEXMAKEOPTS} install || die
	
	# these .so's are strange. they are from the make in programs/ above,
	# and are for apps built with winelib (windows sources built directly
	# against wine). Apparently the sources go into a <program name>.so file
	# and you run it via a symlink <program name> -> wine. Unfortunately both
	# the symlink and the .so apparently must reside in /usr/bin.
	cd ${D}/usr/winex/bin
	chmod a-x *.so
		
	# bash script For users with both wine and winex
	# TODO: find out why this doesn't work
	DESTTREE=/usr/winex dobin ${FILESDIR}/winex
	
	cd ${S}
	dodoc ANNOUNCE AUTHORS BUGS ChangeLog DEVELOPERS-HINTS LICENSE README

	insinto /etc/winex
	doins documentation/samples/*
	doins ${S}/winedefault.reg
	
	dodir /etc/skel/.winex
	dosym /etc/winex/config /etc/skel/.winex/config
	
	insinto /etc/env.d
	doins ${FILESDIR}/81winex
}

pkg_postinst() {

	einfo "If you are installing winex for the first time,
copy /etc/winex/config (global configuration) to ~/.wine/config
and edit that for per-user configuration. Otherwise, winex will
not run.
Also, run \"/usr/winex/bin/regapi setValue < /etc/winex/winedefault.reg\" 
to setup
per-user registry for using winex. More info in 
/usr/share/doc/winex-${PV}."

}

