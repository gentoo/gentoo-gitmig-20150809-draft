# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/wine/wine-20041019.ebuild,v 1.3 2004/10/27 12:54:51 vapier Exp $

inherit eutils flag-o-matic

STAMP=20040716
DESCRIPTION="free implementation of Windows(tm) on Unix - CVS snapshot"
HOMEPAGE="http://www.winehq.com/"
SRC_URI="mirror://sourceforge/${PN}/Wine-${PV}.tar.gz
	 mirror://gentoo/${PN}-${STAMP}-fake_windows.tar.bz2
	 mirror://gentoo/${PN}-${STAMP}-misc.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE="X jack alsa arts cups debug nas opengl tcltk ncurses"

DEPEND="sys-devel/gcc
	sys-devel/flex
	ncurses? ( >=sys-libs/ncurses-5.2 )
	>=media-libs/freetype-2.0.0
	jack? ( media-sound/jack )
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
	unpack ${PN}-${STAMP}-fake_windows.tar.bz2
	mkdir misc ; cd misc
	unpack ${PN}-${STAMP}-misc.tar.bz2

	cd ${S}
	epatch ${FILESDIR}/winearts-kdecvs-fix.patch
	sed -i '/^UPDATE_DESKTOP_DATABASE/s:=.*:=true:' tools/Makefile.in
}

config_cache() {
	local h ans="no"
	use ${1} && ans="yes"
	shift
	for h in "$@" ; do
		export ac_cv_header_${h}=${ans}
	done
}

src_compile() {
	export LDCONFIG=/bin/true
	config_cache jack jack_jack_h
	config_cache cups cups_cups_h
	config_cache alsa alsa_asoundlib_h sys_asoundlib_h
	use arts || export ARTSCCONFIG="/bin/false"
	config_cache nas audio_audiolib_h

	strip-flags

	./configure \
		--prefix=/usr/lib/wine \
		--sysconfdir=/etc/wine \
		--build=${CBUILD:-${CHOST}} \
		--host=${CHOST} \
		--target=${CTARGET:-${CHOST}} \
		$(use_enable ncurses curses) \
		$(use_enable opengl) \
		$(use_enable debug trace) \
		$(use_enable debug) \
		|| die "configure failed"

	emake -j1 depend || die "depend"
	emake all || die "all"
	emake -C programs || die "programs"
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
	cp -r ${WORKDIR}/fake_windows . || die "fake_windows"
	chown root:root fake_windows/ -R

	# Unpacking the miscellaneous files
	cp ${WORKDIR}/misc/* . || die "misc"
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
	dodoc ANNOUNCE AUTHORS BUGS ChangeLog DEVELOPERS-HINTS README

	# Manpage setup

	newman ${D}/usr/lib/${PN}/man/man1/wine.1 ${PN}.1
	rm ${D}/usr/lib/${PN}/man/man1/${PN}.1
	doman ${D}/usr/lib/${PN}/man/man5/wine.conf.5
	rm ${D}/usr/lib/${PN}/man/man5/wine.conf.5
}

pkg_postinst() {
	einfo "Use /usr/bin/wine to start wine. This is a wrapper-script"
	einfo "which will take care of everything else."
	einfo
	einfo "if you have problems with nptl, use wine-pthread to start wine"
	einfo
	einfo "Use /usr/bin/regedit-wine to import registry files into the"
	einfo "wine registry."
}
