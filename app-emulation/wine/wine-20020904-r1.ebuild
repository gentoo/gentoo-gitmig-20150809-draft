# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/wine/wine-20020904-r1.ebuild,v 1.1 2002/09/13 14:48:23 phoenix Exp $

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
	nas? ( media-libs/nas )
	cups? ( net-print/cups )
	opengl? ( virtual/opengl )"

src_compile() {	
	cd ${S}
	local myconf

	use opengl && myconf="--enable-opengl" || myconf="--disable-opengl"
	[ -z $DEBUG ] && myconf="$myconf --disable-trace --disable-debug" || myconf="$myconf --enable-trace --enable-debug"
	# there's no configure flag for cups, arts, alsa and nas, it's supposed to be autodetected
	
	# the folks at #winehq were really angry about custom optimization
	export CFLAGS=""
	export CXXFLAGS=""
	
	./configure --prefix=/usr/lib/wine \
		--sysconfdir=/etc/wine \
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

	local WINEMAKEOPTS="prefix=${D}/usr/lib/wine"
	
	cd ${S}
	make ${WINEMAKEOPTS} install || die
	cd ${S}/programs
	make ${WINEMAKEOPTS} install || die
	
	# Creates /usr/lib/wine/.data with fake_windows in it
	# This is needed for our wine wrapper script
	mkdir ${D}/usr/lib/wine/.data
	cp -R ${WORKDIR}/fake_windows ${D}/usr/lib/wine/.data
	cp ${FILESDIR}/${P}-config ${D}/usr/lib/wine/.data/config
	cp ${WORKDIR}/${P}/winedefault.reg ${D}/usr/lib/wine/.data/winedefault.reg

	# Install the wrapper script
	mkdir ${D}/usr/bin
	cp ${FILESDIR}/${P}-wine ${D}/usr/bin/wine
	cp ${FILESDIR}/${P}-regedit ${D}/usr/bin/regedit-wine

	# Take care of the documentation
	cd ${S}
	dodoc ANNOUNCE AUTHORS BUGS ChangeLog DEVELOPERS-HINTS LICENSE README

	insinto /usr/lib/wine/.data/fake_windows/Windows
	doins documentation/samples/system.ini
	doins documentation/samples/generic.ppd
	
	# Manpage setup
	cp ${D}/usr/lib/${PN}/man/man1/wine.1 ${D}/usr/lib/${PN}/man/man1/${PN}.1
	doman ${D}/usr/lib/${PN}/man/man1/${PN}.1
	rm ${D}/usr/lib/${PN}/man/man1/${PN}.1

	# Remove the executable flag from those libraries.
	cd ${D}/usr/lib/wine/lib/wine
	chmod a-x *.so
}

pkg_postinst() {
	einfo "**********************************************************************"
	einfo "* NOTE: Use /usr/bin/wine to start wine. This is a wrapper-script    *"
	einfo "*       which will take care of everything else.                     *"
	einfo "*       Use /usr/bin/regedit-wine to import registry files into the  *"
	einfo "*       wine registry.                                               *"
	einfo "*       If you have further questions, enhancements or patches       *"
	einfo "*       send an email to phoenix@gentoo.org                          *"
	einfo "*                                                                    *"
	einfo "*       Manpage has been installed to the system.                    *"
	einfo "*       \"man wine\" should show it.                                   *"
	einfo "**********************************************************************"
}

