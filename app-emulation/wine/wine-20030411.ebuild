# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/wine/wine-20030411.ebuild,v 1.4 2003/04/15 07:18:33 cretin Exp $

inherit eutils base flag-o-matic

DESCRIPTION="free implementation of Windows(tm) on Unix - CVS snapshot"
SRC_URI="mirror://gentoo/wine-${PV}.tar.bz2"
HOMEPAGE="http://www.winehq.com/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc"
IUSE="nas arts cups opengl alsa tcltk nptl"

DEPEND="sys-devel/gcc
	sys-devel/flex
	dev-util/yacc
	>=sys-libs/ncurses-5.2
	>=media-libs/freetype-2.0.0
	X? ( virtual/x11 )
	tcltk? ( dev-lang/tcl dev-lang/tk ) 
	arts? ( kde-base/arts )
	alsa? ( media-libs/alsa-lib )
	nas? ( media-libs/nas )
	cups? ( net-print/cups )
	opengl? ( virtual/opengl )"

strip-flags

src_unpack() {
	base_src_unpack
	cd ${S}
	epatch ${FILESDIR}/${P}-xopenfont.patch
}

src_compile() {	
	cd ${S}
	local myconf

	use opengl && myconf="$myconf --enable-opengl" || myconf="$myconf --disable-opengl"
	use nptl && myconf="$myconf --with-nptl" || myconf="$myconf --without-nptl"

	[ -z $DEBUG ] && myconf="$myconf --disable-trace --disable-debug" || myconf="$myconf --enable-trace --enable-debug"
	# there's no configure flag for cups, arts, alsa and nas, it's supposed to be autodetected
	
	./configure --prefix=/usr/lib/wine \
		--sysconfdir=/etc/wine \
		--host=${CHOST} \
		--enable-curses \
		${myconf} || die

	cd ${S}/programs/winetest
	cp Makefile 1
	sed -e 's:wine.pm:include/wine.pm:' 1 > Makefile
	
	# No parallel make
	cd ${S}	
	make depend all || die
	cd programs && emake || die
}

src_install () {
	local WINEMAKEOPTS="prefix=${D}/usr/lib/wine"
	
	### Install wine to ${D}
	cd ${S}
	make ${WINEMAKEOPTS} install || die
	cd ${S}/programs
	make ${WINEMAKEOPTS} install || die
	
	# Needed for later installation
	dodir /usr/bin
 
	### Creation of /usr/lib/wine/.data 
	# Setting up fake_windows
	dodir /usr/lib/wine/.data
	cd ${D}/usr/lib/wine/.data
	tar jxvf ${FILESDIR}/${P}-fake_windows.tar.bz2
	chown root:root fake_windows/ -R

	# Unpacking the miscellaneous files
	tar jxvf ${FILESDIR}/${P}-misc.tar.bz2
	chown root:root config

	# moving the wrappers to bin/
	insinto /usr/bin
	dobin regedit-wine wine
	rm regedit-wine wine

	# copying the winedefault.reg into .data
	insinto /usr/lib/wine/.data
	doins ${WORKDIR}/${P}/winedefault.reg

	# Set up this dynamic data
	cd ${S}
	insinto /usr/lib/wine/.data/fake_windows/Windows
	doins documentation/samples/system.ini
	doins documentation/samples/generic.ppd
	## Setup of .data complete

	### Misc tasks
	# Take care of the documentation
	cd ${S}
	dodoc ANNOUNCE AUTHORS BUGS ChangeLog DEVELOPERS-HINTS LICENSE README

	# Manpage setup
	cp ${D}/usr/lib/${PN}/man/man1/wine.1 ${D}/usr/lib/${PN}/man/man1/${PN}.1
	doman ${D}/usr/lib/${PN}/man/man1/${PN}.1
	rm ${D}/usr/lib/${PN}/man/man1/${PN}.1

	# Remove the executable flag from those libraries.
	cd ${D}/usr/lib/wine/lib/wine
	chmod a-x *.so
}

pkg_postinst() {
	einfo "Use /usr/bin/wine to start wine. This is a wrapper-script"
	einfo "which will take care of everything else."
	einfo ""
	einfo "Use /usr/bin/regedit-wine to import registry files into the"
	einfo "wine registry."
	einfo ""
	einfo "If you have further questions, enhancements or patches"
	einfo "send an email to phoenix@gentoo.org"
}
