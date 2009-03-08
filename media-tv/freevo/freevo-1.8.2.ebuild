# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/freevo/freevo-1.8.2.ebuild,v 1.4 2009/03/08 14:16:36 betelgeuse Exp $

EAPI="2"

inherit distutils eutils

DESCRIPTION="Digital video jukebox (PVR, DVR)."
HOMEPAGE="http://www.freevo.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

IUSE="directfb cdparanoia doc dvd encode fbcon flac gphoto2 jpeg lame lirc matrox mixer nls snes sqlite tv tvtime vorbis xine xmame X"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

# TODO: We could also use dev-libs/libxml2 when
# built with USE=python alternatively to pyxml
RDEPEND="dev-python/pygame
	dev-python/pyxml
	dev-python/elementtree
	dev-python/imaging
	dev-python/beautifulsoup
	>=dev-python/twisted-2.5
	>=dev-python/twisted-web-0.6

	>=dev-python/kaa-base-0.4.0
	>=dev-python/kaa-metadata-0.7.3
	>=dev-python/kaa-imlib2-0.2.3

	media-video/mplayer[directfb?,fbcon?]
	>=media-libs/libsdl-1.2.5[directfb?,fbcon?]
	media-libs/sdl-image[jpeg,png]

	cdparanoia? ( media-sound/cdparanoia )
	dvd? (
		>=media-video/lsdvd-0.10
		directfb? ( media-libs/xine-lib[directfb] )
		fbcon? ( media-libs/xine-lib[fbcon] )
		encode? ( media-video/dvdbackup )
	)
	flac? ( media-libs/flac )
	gphoto2? ( media-libs/libgphoto2 )
	jpeg? ( media-libs/jpeg )
	lame? ( media-sound/lame )
	lirc? ( app-misc/lirc >=dev-python/pylirc-0.0.3 )
	matrox? ( >=media-video/matroxset-0.3 )
	mixer? ( media-sound/aumix )
	snes? ( || ( games-emulation/zsnes games-emulation/snes9x ) )
	sqlite? ( ~dev-python/pysqlite-1.0.1 )
	tv? (	media-tv/xmltv
		tvtime? ( media-tv/tvtime ) )
	xine? ( media-video/xine-ui )
	vorbis? ( media-sound/vorbis-tools )
	xmame? ( games-emulation/xmame )"

pkg_setup() {
	if ! { use X || use directfb || use fbcon || use matrox ; } ; then
		echo
		ewarn "WARNING - no video support specified in USE flags."
		ewarn "Please be sure that media-libs/libsdl supports whatever video"
		ewarn "support (X11, fbcon, directfb, etc) you plan on using."
		echo
	fi
}

src_unpack() {
	distutils_src_unpack
	epatch "${FILESDIR}"/${P}-mplayerargs.patch
}

src_install() {
	distutils_src_install

	insinto /etc/freevo
	newins local_conf.py.example local_conf.py

	if [ "${PROFILE_ARCH}" == "xbox" ]; then
		sed -i -e "s/# MPLAYER_AO_DEV.*/MPLAYER_AO_DEV='alsa1x'/" "${D}"/etc/freevo/local_conf.py
		newins "${FILESDIR}"/xbox-lircrc lircrc
	fi

	if use X; then
		echo "#!/bin/bash" > freevo
		echo "/usr/bin/freevoboot startx" >> freevo
		exeinto /etc/X11/Sessions/
		doexe freevo

		#insinto /etc/X11/dm/Sessions
		#doins "${FILESDIR}/freevo.desktop"

		insinto /usr/share/xsessions
		doins "${FILESDIR}/freevo.desktop"
	fi

	exeinto /usr/bin
	newexe "${FILESDIR}"/${P}.boot freevoboot
	newconfd "${FILESDIR}/freevo.conf" freevo

	rm -rf "${D}/usr/share/doc"

	dodoc ChangeLog FAQ RELEASE_NOTES README TODO \
		Docs/{CREDITS,NOTES,*.txt,plugins/*.txt}
	use doc &&
		cp -r Docs/{installation,html,plugin_writing} "${D}/usr/share/doc/${PF}"

	use nls || rm -rf "${D}"/usr/share/locale

	# Create a default freevo setup
	cd "${S}/src"
	if [ "${PROFILE_ARCH}" == "xbox" ]; then
		myconf="${myconf} --geometry=640x480 --display=x11"
	elif use matrox && use directfb; then
		myconf="${myconf} --geometry=768x576 --display=dfbmga"
	elif use matrox ; then
		myconf="${myconf} --geometry=768x576 --display=mga"
	elif use directfb; then
		myconf="${myconf} --geometry=768x576 --display=directfb"
	elif use X ; then
		myconf="${myconf} --geometry=800x600 --display=x11"
	else
		myconf="${myconf} --geometry=800x600 --display=fbdev"
	fi
	sed -i "s:/etc/freevo/freevo.conf:${D}/etc/freevo/freevo.conf:g" setup_freevo.py || die "Could not fix setup_freevo.py"
	python setup_freevo.py ${myconf} || die "Could not create new freevo.conf"
}

pkg_postinst() {
	echo
	einfo "Please check /etc/freevo/freevo.conf and"
	einfo "/etc/freevo/local_conf.py before starting Freevo."
	einfo "To rebuild freevo.conf with different parameters,"
	einfo "please run:"
	einfo "  # freevo setup"

	ewarn "To update from existing installations, please run"
	ewarn "  # freevo convert_config /etc/freevo/local_conf.py -w"
	ewarn "If you are using the recordserver, be sure to"
	ewarn "read the RELEASE_NOTES in /usr/share/doc/${P}"

	echo
	einfo "To build a freevo-only system, please use the freevoboot"
	einfo "wrapper to be run it as a user. It can be configured in /etc/conf.d/freevo"

	if use X ; then
		echo
		ewarn "If you're using a Freevo-only system with X, you'll need"
		ewarn "to setup the autologin (as user) and choose freevo as"
		ewarn "default session. If you need to run recordserver/webserver"
		ewarn "at boot, please use /etc/conf.d/freevo"
		echo
		ewarn "Should you decide to personalize your freevo.desktop"
		ewarn "session, keep the definition for '/usr/bin/freevoboot startx'"
	else
		echo
		ewarn "If you want Freevo to start automatically,you'll need"
		ewarn "to follow instructions at :"
		ewarn "http://freevo.sourceforge.net/cgi-bin/doc/BootFreevo"
		echo
		ewarn "*NOTE: you can use mingetty or provide a login"
		ewarn "program for getty to autologin as a user with limited privileges."
		ewarn "A tutorial for getty is at:"
		ewarn "http://ubuntuforums.org/showthread.php?t=152274"
	fi

	if [ -e "${ROOT}/etc/init.d/freevo" ] ; then
		echo
		ewarn "Please remove /etc/init.d/freevo as it is a security"
		ewarn "threat. To set autostart read above."
	fi

	if [ -e "${ROOT}/opt/freevo" ] ; then
		echo
		ewarn "Please remove ${ROOT}/opt/freevo because it is no longer used."
	fi
	if [ -e "${ROOT}/etc/freevo/freevo_config.py" ] ; then
		echo
		ewarn "Please remove ${ROOT}/etc/freevo/freevo_config.py."
	fi
	if [ -e "${ROOT}/etc/init.d/freevo-record" ] ; then
		echo
		ewarn "Please remove ${ROOT}/etc/init.d/freevo-record"
	fi
	if [ -e "${ROOT}/etc/init.d/freevo-web" ] ; then
		echo
		ewarn "Please remove ${ROOT}/etc/init.d/freevo-web"
	fi
}
