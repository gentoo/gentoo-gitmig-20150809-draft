# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/wine/wine-20041019-r1.ebuild,v 1.5 2004/10/31 00:57:03 vapier Exp $

inherit eutils flag-o-matic

STAMP=20041027
DESCRIPTION="free implementation of Windows(tm) on Unix - CVS snapshot"
HOMEPAGE="http://www.winehq.com/"
SRC_URI="mirror://sourceforge/${PN}/Wine-${PV}.tar.gz
	 mirror://gentoo/${PN}-${STAMP}-fake_windows.tar.bz2
	 mirror://gentoo/${PN}-${STAMP}-misc.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="-*"
IUSE="X jack alsa arts cups debug nas opengl tcltk ncurses"

DEPEND="sys-devel/gcc
	sys-devel/flex
	ncurses? ( >=sys-libs/ncurses-5.2 )
	>=media-libs/freetype-2.0.0
	jack? ( media-sound/jack-audio-connection-kit )
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
	epatch ${WORKDIR}/misc/config.patch
	epatch ${FILESDIR}/winearts-kdecvs-fix.patch
	epatch ${FILESDIR}/${PV}-load-wrappers.patch
	sed -i '/^UPDATE_DESKTOP_DATABASE/s:=.*:=true:' tools/Makefile.in

	test_flag -fstack-protector && epatch ${FILESDIR}/${PV}-no-stack.patch #66002
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

	#	$(use_enable amd64 win64)
	econf \
		--sysconfdir=/etc/wine \
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
	### Install wine to ${D}
	local WINEMAKEOPTS="
		prefix=${D}/usr
		bindir=${D}/usr/bin
		datadir=${D}/usr/share
		mandir=${D}/usr/share/man
		libdir=${D}/usr/lib
		dlldir=${D}/usr/lib/wine
		"
	make ${WINEMAKEOPTS} install || die "install"
	cd ${S}/programs
	make ${WINEMAKEOPTS} install || die "install programs"

	# Needed for later installation
	dodir /usr/bin

	### Creation of /usr/share/wine/data/
	# Setting up fake_windows
	dodir /usr/share/wine/data
	chown -R root:root ${WORKDIR}/fake_windows/
	cp -r ${WORKDIR}/fake_windows ${D}/usr/share/wine/data/

	# Install our custom wrappers
	cd ${WORKDIR}/misc
	for x in * ; do
		[ "${x}" == "config.patch" ] && continue
		[ -x "${D}/usr/bin/${x}" ] \
			&& mv "${D}"/usr/bin/${x}{,-bin}
		dobin ${x}
	done
	dosym regedit.exe.so /usr/lib/wine/regedit-bin.exe.so

	# copying the wine.inf into .data (used to be winedefault.reg)
	cd ${S}
	insinto /usr/share/wine/data
	doins documentation/samples/config || die "doins config"
	doins tools/wine.inf
	insinto /usr/share/wine/data/fake_windows/Windows/System
	doins tools/wine.inf
	insinto /usr/share/wine/data/fake_windows/Windows/Inf
	doins tools/wine.inf

	### Misc tasks
	# Take care of the documentation
	cd ${S}
	dodoc ANNOUNCE AUTHORS BUGS ChangeLog DEVELOPERS-HINTS README
}

pkg_postinst() {
	einfo "Use /usr/bin/wine to start wine. This is a wrapper-script"
	einfo "which will take care of everything else."
	einfo
	einfo "if you have problems with nptl, use wine-pthread to start wine"
}
