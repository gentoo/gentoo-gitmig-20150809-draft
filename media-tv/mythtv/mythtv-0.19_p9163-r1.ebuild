# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/mythtv/mythtv-0.19_p9163-r1.ebuild,v 1.13 2006/09/04 15:48:34 cardoe Exp $

inherit flag-o-matic multilib eutils debug qt3

PATCHREV=9163
MY_PV="${PV%_*}"

DESCRIPTION="Homebrew PVR project"
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${PN}-${MY_PV}.tar.bz2
	http://dev.gentoo.org/~cardoe/files/${PN}-${MY_PV}-rev${PATCHREV}.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"

IUSE_VIDEO_CARDS="video_cards_i810 video_cards_nvidia video_cards_via"

IUSE="alsa altivec backendonly debug dbox2 dvb dvd frontendonly ieee1394 jack joystick lcd lirc mmx vorbis opengl xvmc ${IUSE_VIDEO_CARDS}"

RDEPEND=">=media-libs/freetype-2.0
	>=media-sound/lame-3.93.1
	|| ( (	x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXinerama
		x11-libs/libXv
		x11-libs/libXrandr
		x11-libs/libXxf86vm
		)
	virtual/x11 )
	xvmc? (
		|| ( x11-libs/libXvMC virtual/x11 )
		video_cards_nvidia? ( || ( media-video/nvidia-glx
								 x11-drivers/nvidia-drivers
								 x11-drivers/nvidia-legacy-drivers ) )
		video_cards_via? ( || ( x11-drivers/xf86-video-via virtual/x11 ) )
		video_cards_i810? ( || ( x11-drivers/xf86-video-i810 virtual/x11 ) )
	)
	$(qt_min_version 3.3)
	dev-db/mysql
	alsa? ( >=media-libs/alsa-lib-0.9 )
	dvd? ( 	media-libs/libdvdnav
		media-libs/libdts )
	dvb? ( media-libs/libdvb media-tv/linuxtv-dvb-headers )
	jack? ( media-sound/jack-audio-connection-kit )
	lcd? ( =app-misc/lcdproc-0.4* )
	lirc? ( app-misc/lirc )
	vorbis? ( media-libs/libvorbis )
	opengl? ( virtual/opengl )
	ieee1394? (	>=sys-libs/libraw1394-1.2.0
			>=sys-libs/libavc1394-0.5.0
			>=media-libs/libiec61883-1.0.0 )
	|| ( >=net-misc/wget-1.9.1 >=media-tv/xmltv-0.5.34 )
	!<x11-base/xorg-x11-6.8"

DEPEND="${RDEPEND}
	|| ( x11-apps/xinit virtual/x11 )"

PDEPEND="=x11-themes/mythtv-themes-${MY_PV}*"

S="${WORKDIR}/${PN}-${MY_PV}"

MYTHTV_GROUPS="video,audio,tty"

pkg_setup() {

	local rip=0
	if ! built_with_use =x11-libs/qt-3* mysql opengl ; then
		echo
		eerror "MythTV requires Qt to be built with mysql and opengl use flags enabled."
		eerror "Please re-emerge =x11-libs/qt-3, after having the use flags set."
		echo
		rip=1
	fi

	if ! has_version x11-libs/libXv && ! built_with_use x11-base/xorg-x11 xv; then
		eerror "MythTv requires xorg-x11 to be built with XV support. Please add"
		eerror "'xv' to your USE flags, and re-emerge x11-base/xorg-x11."
		rip=1
	fi

	if use xvmc && use video_cards_nvidia; then
		echo
		ewarn "You enabled the 'xvmc' USE flag, you must have a GeForce 4 or"
		ewarn "greater to use this. Otherwise, you'll have crashes with MythTV"
		echo
	fi

	if built_with_use dev-db/mysql utf8; then
		echo
		ewarn "Your MySQL installation on this machine most likely won't work"
		ewarn "because you compiled it with USE=utf8. Either use another mysql"
		ewarn "server (on another machine) or recompile MySQL without utf8."
		echo
	fi

	if has x11-libs/libX11 virtual/x11; then
		echo
		eerror "Your installation of Modular X is broken. Don't have a virtual/x11"
		eerror "installed while using Modular X."
		echo
		rip=1
	fi

	[[ $rip == 1 ]] && die "Please fix the above issues, before continuing."

	echo
	einfo "This ebuild now uses a heavily stripped down version of your CFLAGS"
	einfo "Don't complain because your -momfg-fast-speed CFLAG is being stripped"
	einfo "Only additional CFLAG issues that will be addressed are for binary"
	einfo "package building."
	echo
}

src_unpack() {
	unpack ${A}
	cd ${S}

	#Fixes of the bugs found in the 0.19 release
	epatch "${WORKDIR}"/${PN}-${MY_PV}-rev${PATCHREV}.patch

	# Support installing in libdir != lib
	epatch "${FILESDIR}/mythtv-0.19-libdir.patch"
}

src_compile() {
	local myconf="--prefix=/usr
		--mandir=/usr/share/man
		--libdir-name=$(get_libdir)"
	use alsa || myconf="${myconf} --disable-audio-alsa"
	use jack || myconf="${myconf} --disable-audio-jack"
	use altivec || myconf="${myconf} --disable-altivec"
	use xvmc && myconf="${myconf} --enable-xvmc"
	myconf="${myconf}
		--disable-audio-arts
		$(use_enable lirc)
		$(use_enable joystick joystick-menu)
		$(use_enable dbox2)
		$(use_enable dvb)
		$(use_enable dvb dvb-eit)
		--dvb-path=/usr/include
		$(use_enable dvd)
		$(use_enable opengl opengl-vsync)
		$(use_enable ieee1394 firewire)
		--enable-xrandr
		--enable-xv
		--disable-directfb
		--enable-x11
		--enable-proc-opt"

	if use mmx || use amd64; then
		myconf="${myconf} --enable-mmx"
	else
		myconf="${myconf} --disable-mmx"
	fi

	if use debug; then
		myconf="${myconf} --compile-type=debug"
	else
		myconf="${myconf} --compile-type=release"
	fi

	## CFLAG cleaning so it compiles
	MARCH=$(get-flag "march")
	MTUNE=$(get-flag "mtune")
	MCPU=$(get-flag "mcpu")
	strip-flags
	filter-flags "-march=*" "-mtune=*" "-mcpu=*"
	filter-flags "-O" "-O?"

	if [[ -n "${MARCH}" ]]; then
		myconf="${myconf} --arch=${MARCH}"
	fi
	if [[ -n "${MTUNE}" ]]; then
		myconf="${myconf} --tune=${MTUNE}"
	fi
	if [[ -n "${MCPU}" ]]; then
		myconf="${myconf} --cpu=${MCPU}"
	fi

#	myconf="${myconf} --extra-cxxflags=\"${CXXFLAGS}\" --extra-cflags=\"${CFLAGS}\""
	hasq distcc ${FEATURES} || myconf="${myconf} --disable-distcc"
	hasq ccache ${FEATURES} || myconf="${myconf} --disable-ccache"

	if use frontendonly; then
		##Backend Removal
		ewarn
		ewarn "You are using the experimental feature for only installing the frontend."
		ewarn "You will not get Gentoo support nor support from MythTV upstream for this."
		ewarn "If this breaks, you own both pieces."
		ewarn
		myconf="${myconf} --disable-backend"
	fi

	if use backendonly; then
		##Frontend Removal
		ewarn
		ewarn "You are using the experimental feature for only installing the backend."
		ewarn "You will not get Gentoo support nor support from MythTV upstream for this."
		ewarn "If this breaks, you own both pieces."
		ewarn
		myconf="${myconf} --disable-frontend"
	fi

	# let MythTV come up with our CFLAGS. Upstream will support this
	CFLAGS=""
	CXXFLAGS=""
	einfo "Running ./configure ${myconf}"
	./configure ${myconf} || die "configure died"

	${QTDIR}/bin/qmake QMAKE=${QTDIR}/bin/qmake -o "Makefile" mythtv.pro || die "qmake failed"
	emake || die "emake failed"

}

src_install() {

	einstall INSTALL_ROOT="${D}" || die "install failed"
	for doc in AUTHORS COPYING FAQ UPGRADING ChangeLog README; do
		test -e "${doc}" && dodoc ${doc}
	done

	if ! use frontendonly; then
		insinto /usr/share/mythtv/database
		doins database/*

		exeinto /usr/share/mythtv
		doexe "${FILESDIR}/mythfilldatabase.cron"

		newinitd ${FILESDIR}/mythbackend-0.18.2.rc mythbackend
		newconfd ${FILESDIR}/mythbackend-0.18.2.conf mythbackend
	fi

	if ! use backendonly; then
		dobin ${FILESDIR}/runmythfe

		ewarn "Want MythFrontend to always? Add the following to your"
		ewarn "myth user. i.e. My user is mythtv"
		echo "crontab -e -u mythtv"
		echo "* * * * * /usr/bin/runmythfe &"
		ewarn "And you're all set."
	fi
	dodoc keys.txt docs/*.{txt,pdf}
	dohtml docs/*.html

	keepdir /etc/mythtv
	chown -R mythtv "${D}"/etc/mythtv
	keepdir /var/log/mythtv
	chown -R mythtv "${D}"/var/log/mythtv

	insinto /usr/share/mythtv/contrib
	doins contrib/*
}

pkg_preinst() {
	enewuser mythtv -1 "-1" -1 ${MYTHTV_GROUPS} || die "Problem adding mythtv user"
	usermod -G ${MYTHTV_GROUPS} mythtv
}

pkg_postinst() {
	einfo "Want MythFrontend to alway run? Run the following:"
	echo " #crontab -e -u mythtv"
	einfo "And add the following:"
	echo "* * * * * /usr/bin/runmythfe &"
	echo
	echo
	einfo "To always have MythBackend running and available run the following:"
	echo "rc-update add mythbackend default"
	echo
	ewarn "Your recordings folder must be owned by the user 'mythtv' now"
	echo "chown -R mythtv /path/to/store"
}

