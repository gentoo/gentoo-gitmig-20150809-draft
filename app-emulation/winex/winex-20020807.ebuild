# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/winex/winex-20020807.ebuild,v 1.2 2002/08/19 17:50:20 cybersystem Exp $

S=${WORKDIR}/wine
DESCRIPTION="WineX is a distribution of Wine with enhanced DirectX for gaming"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	mirror://gentoo/${P}-fake_windows.tar.bz2"
HOMEPAGE="http://www.transgaming.com/"

SLOT="0"
KEYWORDS="x86 -ppc"
LICENSE="Aladdin"

DEPEND="virtual/x11
	sys-devel/gcc
	sys-devel/flex
	dev-util/yacc
	opengl? ( virtual/opengl )
	>=sys-libs/ncurses-5.2
	cups? ( net-print/cups )
	>=media-libs/freetype-2.0.0
	dev-lang/tcl dev-lang/tk"

RDEPEND="${DEPEND}"

src_compile() {
	# Azarah's patches
	#patch -p0 < ${FILESDIR}/${P}-opengl.patch || die "opengl-patch failed"
    
	cd ${S}
	local myconf

	use opengl && myconf="--enable-opengl" || myconf="--disable-opengl"
	[ -z $DEBUG ] && myconf="$myconf --disable-trace --disable-debug" || myconf="$myconf --enable-trace --enable-debug"

	# the folks at #winehq were really angry about custom optimization
	unset CFLAGS
	unset CXXFLAGS
	
	./configure --prefix=/usr/lib/winex \
	--sysconfdir=/etc/winex \
	--host=${CHOST} \
	--enable-curses \
	--with-x \
	${myconf} || die "configure failed"

	# Fixes a winetest issue
	cd ${S}/programs/winetest
	cp Makefile 1
	sed -e 's:wine.pm:include/wine.pm:' 1 > Makefile

	# This persuades wineshelllink that "winex" is a better loader :)
	cd ${S}/tools
	cp wineshelllink 1
	sed -e 's/\(WINE_LOADER=\)\(\${WINE_LOADER:-wine}\)/\1winex/' 1 > wineshelllink

	cd ${S}	
	make depend all || die "make depend all failed"
	cd programs && emake || die "emake died"
}

src_install () {

	local WINEXMAKEOPTS="prefix=${D}/usr/lib/winex"
	
	# Installs winex to /usr/lib/winex
	cd ${S}
	make ${WINEXMAKEOPTS} install || die "make install failed"
	cd ${S}/programs
	make ${WINEXMAKEOPTS} install || die "make install failed"
	

	# Creates /usr/lib/winex/.data with fake_windows in it
	# This is needed for our new winex wrapper script
	mkdir ${D}/usr/lib/winex/.data
	cp -R ${WORKDIR}/fake_windows ${D}/usr/lib/winex/.data
	cp ${FILESDIR}/${P}-config ${D}/usr/lib/winex/.data/config

	# winedefault.reg doesnt exist anymore
	cp ${WORKDIR}/wine/winedefault.reg ${D}/usr/lib/winex/.data/winedefault.reg

	# Install the wrapper script
	mkdir ${D}/usr/bin
	cp ${FILESDIR}/${P}-winex ${D}/usr/bin/winex
	cp ${FILESDIR}/${P}-regedit ${D}/usr/bin/regedit

	# Take care of the other stuff
	cd ${S}
	dodoc ANNOUNCE AUTHORS BUGS ChangeLog DEVELOPERS-HINTS LICENSE README

	insinto /usr/lib/winex/.data/fake_windows/Windows
	doins documentation/samples/system.ini
	doins documentation/samples/generic.ppd
	
	# Remove the executable flag from those libraries.
	cd ${D}/usr/lib/winex/bin
	chmod a-x *.so
		
}

pkg_postinst() {
	einfo "**********************************************************************"
	einfo "* NOTE: Use /usr/bin/winex to start winex.                           *"
	einfo "*       This is a wrapper-script which will take care of everything  *"
	einfo "*       else. If you have further questions, enhancements or patches *"
	einfo "*       send an email to phoenix@gentoo.org                          *"
	einfo "**********************************************************************"
}

