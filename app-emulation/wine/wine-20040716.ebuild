# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/wine/wine-20040716.ebuild,v 1.3 2004/10/25 14:16:13 vapier Exp $

inherit eutils base

DESCRIPTION="free implementation of Windows(tm) on Unix - CVS snapshot"
HOMEPAGE="http://www.winehq.com/"
SRC_URI="mirror://sourceforge/${PN}/Wine-${PV}.tar.gz
	 mirror://gentoo/${P}-fake_windows.tar.bz2
	 mirror://gentoo/${P}-misc.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="-* x86"
IUSE="X alsa arts cups debug nas nptl opengl tcltk"

DEPEND="sys-devel/gcc
	sys-devel/flex
	>=sys-libs/ncurses-5.2
	>=media-libs/freetype-2.0.0
	X? ( virtual/x11 )
	tcltk? ( dev-lang/tcl dev-lang/tk )
	arts? ( kde-base/arts )
	alsa? ( media-libs/alsa-lib )
	nas? ( media-libs/nas )
	cups? ( net-print/cups )
	opengl? ( virtual/opengl )
	>=sys-apps/sed-4"

src_unpack() {
	unpack Wine-${PV}.tar.gz
	cd ${S}
	epatch ${FILESDIR}/winearts-kdecvs-fix.patch
	epatch ${FILESDIR}/QueryActCtxw_Photoshop7.0.diff
}

src_compile() {
	# there's no configure flag for cups, arts, alsa and nas, it's supposed to be autodetected

	unset CFLAGS CXXFLAGS LDFLAGS

	ac_cv_header_jack_jack_h=no \
	ac_cv_lib_soname_jack= \
	./configure \
		--prefix=/usr/lib/wine \
		--sysconfdir=/etc/wine \
		--host=${CHOST} \
		--enable-curses \
		`use_enable opengl` \
		`use_with nptl` \
		`use_enable debug trace` \
		`use_enable debug` \
		|| die "configure failed"

	cd ${S}/programs/winetest
	sed -i 's:wine.pm:include/wine.pm:' Makefile

	# No parallel make
	cd ${S}
	make depend all || die
	cd programs && emake || die
}

src_install() {
	local WINEMAKEOPTS="prefix=${D}/usr/lib/wine"

	### Install wine to ${D}
	make ${WINEMAKEOPTS} install || die
	cd ${S}/programs
	make ${WINEMAKEOPTS} install || die

	# Needed for later installation
	dodir /usr/bin

	### Creation of /usr/lib/wine/.data
	# Setting up fake_windows
	dodir /usr/lib/wine/.data
	cd ${D}/usr/lib/wine/.data
	tar jxvf ${DISTDIR}/${P}-fake_windows.tar.bz2 || die
	chown root:root fake_windows/ -R

	# Unpacking the miscellaneous files
	tar jxvf ${DISTDIR}/${P}-misc.tar.bz2 ||die
	chown root:root config

	# moving the wrappers to bin/
	insinto /usr/bin
	dobin regedit-wine wine winedbg wine-pthread
	rm regedit-wine wine winedbg wine-pthread

	# copying the wine.inf into .data (used to be winedefault.reg)
	cd ${S}
	dodir /usr/lib/wine/.data
	insinto /usr/lib/wine/.data
	doins tools/wine.inf
	insinto /usr/lib/wine/.data/fake_windows/Windows/System
	doins tools/wine.inf
	insinto /usr/lib/wine/.data/fake_windows/Windows/Inf
	doins tools/wine.inf

	### Misc tasks
	# Take care of the documentation
	cd ${S}
	dodoc ANNOUNCE AUTHORS BUGS ChangeLog DEVELOPERS-HINTS LICENSE README

	# Manpage setup
	cp ${D}/usr/lib/${PN}/man/man1/wine.1 ${D}/usr/lib/${PN}/man/man1/${PN}.1
	doman ${D}/usr/lib/${PN}/man/man1/${PN}.1
	rm ${D}/usr/lib/${PN}/man/man1/${PN}.1
	doman ${D}/usr/lib/${PN}/man/man5/wine.conf.5
	rm ${D}/usr/lib/${PN}/man/man5/wine.conf.5

	# Remove the executable flag from those libraries.
	cd ${D}/usr/lib/wine/lib/wine
	chmod a-x *.so
}

pkg_postinst() {
	einfo "Use /usr/bin/wine to start wine. This is a wrapper-script"
	einfo "which will take care of everything else."
	einfo ""
	einfo "if you have problems with nptl, use wine-pthread to start wine"
	einfo ""
	einfo "Use /usr/bin/regedit-wine to import registry files into the"
	einfo "wine registry."
}
