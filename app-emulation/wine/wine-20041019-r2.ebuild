# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/wine/wine-20041019-r2.ebuild,v 1.4 2004/11/01 03:44:46 vapier Exp $

inherit eutils flag-o-matic

STAMP1=20041027
STAMP2=20041030
DESCRIPTION="free implementation of Windows(tm) on Unix - CVS snapshot"
HOMEPAGE="http://www.winehq.com/"
SRC_URI="mirror://sourceforge/${PN}/Wine-${PV}.tar.gz
	mirror://gentoo/${PN}-${STAMP1}-fake_windows.tar.bz2
	mirror://gentoo/${PN}-${STAMP2}-misc.tar.bz2
	http://dev.gentoo.org/~vapier/dist/${PN}-${STAMP2}-misc.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="-*"
IUSE="X alsa arts cups debug nas opengl gif glut jack jpeg oss ncurses doc"

RDEPEND=">=media-libs/freetype-2.0.0
	ncurses? ( >=sys-libs/ncurses-5.2 )
	jack? ( media-sound/jack-audio-connection-kit )
	X? ( virtual/x11 )
	arts? ( kde-base/arts )
	alsa? ( media-libs/alsa-lib )
	nas? ( media-libs/nas )
	cups? ( net-print/cups )
	opengl? ( virtual/opengl )
	gif? ( media-libs/libungif )
	jpeg? ( media-libs/jpeg )
	glut? ( virtual/glut )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	sys-devel/bison
	sys-devel/gcc
	doc? ( app-text/docbook-sgml-utils app-text/jadetex )
	sys-devel/flex"

src_unpack() {
	unpack Wine-${PV}.tar.gz
	unpack ${PN}-${STAMP1}-fake_windows.tar.bz2
	mkdir misc ; cd misc
	unpack ${PN}-${STAMP2}-misc.tar.bz2

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
		export ac_cv_${h}=${ans}
	done
}

src_compile() {
	export LDCONFIG=/bin/true
	config_cache jack header_jack_jack_h
	config_cache cups header_cups_cups_h
	config_cache alsa header_alsa_asoundlib_h header_sys_asoundlib_h lib_asound_snd_pcm_open
	config_cache arts path_ARTSCCONFIG
	config_cache nas header_audio_audiolib_h header_audio_soundlib_h
	config_cache gif header_gif_lib_h
	config_cache glut lib_glut_glutMainLoop
	config_cache jpeg header_jpeglib_h
	config_cache oss sys_soundcard_h header_machine_soundcard_h header_soundcard_h

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
	if use doc ; then
		emake -C documentation doc || die "docs"
	fi
}

src_install() {
	make \
		prefix=${D}/usr \
		bindir=${D}/usr/bin \
		datadir=${D}/usr/share \
		mandir=${D}/usr/share/man \
		libdir=${D}/usr/lib \
		dlldir=${D}/usr/lib/wine \
		install || die
	use doc && dodoc documentation/*.pdf

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
