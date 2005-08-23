# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/wine/wine-20050419.ebuild,v 1.10 2005/08/23 01:13:01 vapier Exp $

inherit eutils flag-o-matic multilib

DESCRIPTION="free implementation of Windows(tm) on Unix"
HOMEPAGE="http://www.winehq.com/"
SRC_URI="mirror://sourceforge/${PN}/Wine-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="X alsa arts cups debug nas opengl gif glut jack jpeg oss ncurses doc lcms"
RESTRICT="test" #72375

RDEPEND=">=media-libs/freetype-2.0.0
	media-fonts/corefonts
	ncurses? ( >=sys-libs/ncurses-5.2 )
	jack? ( media-sound/jack-audio-connection-kit )
	X? ( virtual/x11 )
	arts? ( kde-base/arts )
	alsa? ( media-libs/alsa-lib )
	nas? ( media-libs/nas )
	cups? ( net-print/cups )
	opengl? ( virtual/opengl )
	gif? ( media-libs/giflib )
	jpeg? ( media-libs/jpeg )
	glut? ( virtual/glut )
	lcms? ( media-libs/lcms )
	amd64? (
		>=app-emulation/emul-linux-x86-xlibs-2.1
		>=app-emulation/emul-linux-x86-soundlibs-2.1
		>=sys-kernel/linux-headers-2.6
	)"
DEPEND="${RDEPEND}
	sys-devel/bison
	doc? ( app-text/docbook-sgml-utils app-text/jadetex )
	sys-devel/flex"

pkg_setup() {
	if use amd64 ; then
		if ! has_m32 ; then
			eerror "Your compiler seems to be unable to compile 32bit code."
			eerror "Make sure you compile gcc with:"
			echo
			eerror "    USE=multilib FEATURES=-sandbox"
			die "Cannot produce 32bit code"
		fi
		if has_multilib_profile ; then
			export ABI=x86
		else
			append-flags -m32
			append-ldflags -m32
		fi
	fi
}

src_unpack() {
	unpack Wine-${PV}.tar.gz
	cd "${S}"

	epatch "${FILESDIR}"/wine-20050524-alsa-headers.patch
	epatch "${FILESDIR}"/winearts-kdecvs-fix.patch
	epatch "${FILESDIR}"/wine-hangfix-bug2660.patch #98156
	sed -i '/^UPDATE_DESKTOP_DATABASE/s:=.*:=true:' tools/Makefile.in
	epatch "${FILESDIR}"/20041019-no-stack.patch #66002
	epatch "${FILESDIR}"/wine-cvs-winelauncher-temp.patch #101773
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
	use arts || export ARTSCCONFIG="/bin/false"
	config_cache nas header_audio_audiolib_h header_audio_soundlib_h
	config_cache gif header_gif_lib_h
	config_cache glut lib_glut_glutMainLoop
	config_cache jpeg header_jpeglib_h
	config_cache oss header_sys_soundcard_h header_machine_soundcard_h header_soundcard_h
	config_cache lcms header_lcms_h

	strip-flags
	use lcms && append-flags -I"${ROOT}"/usr/include/lcms

	if ! built_with_use app-text/docbook-sgml-utils tetex ; then
		export DB2PDF=true
		export DB2PS=true
	fi

	#	$(use_enable amd64 win64)
	# USE=debug is broken in this release
	econf \
		CC=$(tc-getCC) \
		--sysconfdir=/etc/wine \
		$(use_with ncurses curses) \
		$(use_with opengl) \
		$(use_with X x) \
		$(use_enable debug trace) \
		$(use_enable debug) \
		|| die "configure failed"

	emake -j1 depend || die "depend"
	emake all || die "all"
	if use doc ; then
		VARTEXFONTS=${T} \
		emake -j1 -C documentation doc || die "docs"
	fi
}

src_install() {
	make \
		prefix="${D}"/usr \
		bindir="${D}"/usr/bin \
		datadir="${D}"/usr/share \
		includedir="${D}"/usr/include/wine \
		sysconfdir="${D}"/etc/wine \
		mandir="${D}"/usr/share/man \
		libdir="${D}"/usr/$(get_libdir) \
		dlldir="${D}"/usr/$(get_libdir)/wine \
		install || die
	use doc && dodoc documentation/*.pdf

	insinto /usr/share/wine
	doins documentation/samples/config || die "doins config"

	dodoc ANNOUNCE AUTHORS BUGS ChangeLog DEVELOPERS-HINTS README
}
