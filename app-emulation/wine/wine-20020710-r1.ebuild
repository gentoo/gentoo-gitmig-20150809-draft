# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/wine/wine-20020710-r1.ebuild,v 1.6 2002/07/28 04:29:17 raker Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Wine is a free implementation of Windows on Unix."
SRC_URI="ftp://metalab.unc.edu/pub/Linux/ALPHA/wine/development/Wine-${PV}.tar.gz"
HOMEPAGE="http://www.winehq.com/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc -sparc64"

DEPEND="virtual/x11
	sys-devel/gcc
	sys-devel/flex
	dev-util/yacc
	dev-lang/tcl dev-lang/tk
	>=sys-libs/ncurses-5.2
	>=media-libs/freetype-2.0.0
	arts? ( kde-base/arts )
	alsa? ( media-libs/alsa-lib )
	cups? ( net-print/cups )
	opengl? ( virtual/opengl )"

src_compile() {
	
	cd ${S}
	local myconf

	use opengl && myconf="--enable-opengl" || myconf="--disable-opengl"
	[ -z $DEBUG ] && myconf="$myconf --disable-trace --disable-debug" || myconf="$myconf --enable-trace --enable-debug"
	# there's no configure flag for cups, arts and alsa, it's supposed to be autodetected
	
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
	doins samples/*
	doins ${S}/winedefault.reg
	
	dodir /etc/skel/.wine
	dosym /etc/wine/config /etc/skel/.wine/config
	
	insinto /etc/env.d
	doins ${FILESDIR}/80wine

	# for some reason regapi isn't installing... 
	insinto /usr/wine/bin
	insopts -m 755
	doins ${S}/programs/regapi/regapi

}

pkg_postinst() {

	einfo "If you are installing wine for the first time,
copy /etc/wine/config (global configuration) to ~/.wine/config
and edit that for per-user configuration. Otherwise, wine will
not run.
Also, run \"wine regapi setValue < /etc/wine/winedefault.reg\" to setup
per-user registry for using wine. More info in /usr/share/doc/wine-${PV}."

}

