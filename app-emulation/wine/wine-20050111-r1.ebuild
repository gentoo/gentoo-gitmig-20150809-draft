# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/wine/wine-20050111-r1.ebuild,v 1.4 2005/03/29 01:35:08 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="free implementation of Windows(tm) on Unix - CVS snapshot"
HOMEPAGE="http://www.winehq.com/"
SRC_URI="mirror://sourceforge/${PN}/Wine-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="-* x86"
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
	lcms? ( media-libs/lcms )"
DEPEND="${RDEPEND}
	sys-devel/bison
	doc? ( app-text/docbook-sgml-utils app-text/jadetex )
	sys-devel/flex"

src_unpack() {
	unpack Wine-${PV}.tar.gz
	cd "${S}"

	epatch "${FILESDIR}"/${P}-upstream-registry-fix.patch.bz2 #85387

	epatch "${FILESDIR}"/winearts-kdecvs-fix.patch
	sed -i '/^UPDATE_DESKTOP_DATABASE/s:=.*:=true:' tools/Makefile.in

	test_flag -fstack-protector && epatch "${FILESDIR}"/20041019-no-stack.patch #66002
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
	use lcms && append-flags -I${ROOT}/usr/include/lcms

	if ! built_with_use app-text/docbook-sgml-utils tetex ; then
		export DB2PDF=true
		export DB2PS=true
	fi

	#	$(use_enable amd64 win64)
	# USE=debug is broken in this release
	econf \
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
		libdir="${D}"/usr/lib \
		dlldir="${D}"/usr/lib/wine \
		install || die
	use doc && dodoc documentation/*.pdf

	insinto /usr/share/wine
	doins documentation/samples/config || die "doins config"

	dodoc ANNOUNCE AUTHORS BUGS ChangeLog DEVELOPERS-HINTS README
}
