# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/mythfrontend/mythfrontend-0.17.ebuild,v 1.4 2005/03/26 08:20:51 cardoe Exp $

inherit myth flag-o-matic eutils

DESCRIPTION="Homebrew PVR project frontend."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/mythtv-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="alsa arts dvb lcd lirc nvidia cle266 opengl xv mmx ieee1394"

DEPEND=">=media-libs/freetype-2.0
	>=media-sound/lame-3.93.1
	>=x11-libs/qt-3.1
	dev-db/mysql
	alsa? ( >=media-libs/alsa-lib-0.9 )
	>=sys-apps/sed-4
	arts? ( kde-base/arts )
	dvb? ( media-libs/libdvb )
	lcd? ( app-misc/lcdproc )
	lirc? ( app-misc/lirc )
	nvidia? ( media-video/nvidia-glx )
	ieee1394? ( sys-libs/libraw1394 )"

RDEPEND="${DEPEND}
	!media-tv/mythtv"

S=${WORKDIR}/mythtv-${PV}

pkg_setup() {
	local qt_use="$(</var/db/pkg/`best_version x11-libs/qt`/USE)"
	if ! has mysql ${qt_use} ; then
		eerror "Qt is missing MySQL support. Please add"
		eerror "'mysql' to your USE flags, and re-emerge Qt."
		die "Qt needs MySQL support"
	fi

	if use ieee1394; then
		echo
		ewarn "If you want to USE 'ieee1394', you need to install libiec61883"
		ewarn "which is not available in Portage at this time. Do this at your"
		ewarn "own risk. No Support provided."
		echo
	fi

	if use nvidia; then
		echo
		ewarn "You enabled the 'nvidia' USE flag, you must have a GeForce 4 or"
		ewarn "greater to use this. Otherwise, you'll have crashes with MythTV"
		echo
	fi
}

setup_pro() {

	sed -e "s:CONFIG  += linux backend:CONFIG  += linux:" \
		-i 'settings.pro' || die "Removal of mythbackend failed"

	if [ "${ARCH}" == "amd64" ] || ! use mmx; then
		sed -e "s:DEFINES += MMX:DEFINES -= MMX:" \
			-i 'settings.pro' || "Removal of MMX failed"
	fi

	if ! use xv ; then
		sed -e 's:CONFIG += using_xv:#CONFIG += using_xv:' \
			-e 's:EXTRA_LIBS += -L/usr/X11R6/lib:#EXTRA_LIBS += -L/usr/X11R6/lib:' \
			-i 'settings.pro' || die "disable xv failed"
	fi

	if use lcd ; then
		sed -e 's:#DEFINES += LCD_DEVICE:DEFINES += LCD_DEVICE:' \
			-i 'settings.pro' || die "enable lcd sed failed"
	fi

	if use alsa ; then
		sed -e 's:#CONFIG += using_alsa:CONFIG += using_alsa:' \
			-e 's:#ALSA_LIBS = -lasound:ALSA_LIBS = -lasound:' \
			-i 'settings.pro' || die "enable alsa sed failed"
	fi

	if use arts ; then
		sed -e 's:artsc/artsc.h:artsc.h:' \
			-i "libs/libmyth/audiooutputarts.h" || die "sed failed"
		sed -e 's:#CONFIG += using_arts:CONFIG += using_arts:' \
			-e 's:#ARTS_LIBS = .*:ARTS_LIBS = `artsc-config --libs`:' \
			-e 's:#EXTRA_LIBS += -L/opt/.*:EXTRA_LIBS += `artsc-config --libs`:' \
			-e 's:#INCLUDEPATH += /opt/.*:QMAKE_CXXFLAGS += `artsc-config --cflags`:' \
			-i 'settings.pro' || die "enable arts sed failed"
	fi

	if use dvb ; then
		sed -e 's:#CONFIG += using_dvb:CONFIG += using_dvb:' \
			-e 's:#DEFINES += USING_DVB:DEFINES += USING_DVB:' \
			-e 's:#INCLUDEPATH += /usr/src/.*:INCLUDEPATH += /usr/include/linux/dvb:' \
			-i 'settings.pro' || die "enable dvb sed failed"
	fi

	if use lirc ; then
		sed -e 's:#CONFIG += using_lirc:CONFIG += using_lirc:' \
			-e 's:#LIRC_LIBS = -llirc_client:LIRC_LIBS = -llirc_client:' \
			-i 'settings.pro' || die "enable lirc sed failed"
	fi

	if use nvidia ; then
		sed -e 's:#CONFIG += using_xvmc:CONFIG += using_xvmc:' \
			-e 's:#DEFINES += USING_XVMC:DEFINES += USING_XVMC:' \
			-e 's:#EXTRA_LIBS += -lXvMCNVIDIA:EXTRA_LIBS += -lXvMCNVIDIA:' \
			-i 'settings.pro' || die "enable nvidia xvmc sed failed"
	fi

	if use nvidia && use cle266; then
		die "You can not have USE="cle266" and USE="nvidia" at the same time. Must disable one or the other."
	fi

	if use cle266 ; then
		sed -e 's:#CONFIG += using_xvmc using_xvmc_vld:CONFIG += using_xvmc using_xvmc_vld:' \
			-e 's:#DEFINES += USING_XVMC USING_XVMC_VLD:DEFINES += USING_XVMC USING_XVMC_VLD:' \
			-e 's:#EXTRA_LIBS += -lviaXvMC -lXvMC:EXTRA_LIBS += -lviaXvMC -lXvMC:' \
			-i 'settings.pro' || die "enable cle266 sed failed"
	fi

	if ! use cle266 ; then # needed because nvidia and cle266 are not compatible
		sed -e 's:CONFIG += using_xvmc using_xvmc_vld:#CONFIG += using_xvmc using_xvmc_vld:' \
			-e 's:DEFINES += USING_XVMC USING_XVMC_VLD:#DEFINES += USING_XVMC USING_XVMC_VLD:' \
			-e 's:EXTRA_LIBS += -lviaXvMC -lXvMC:#EXTRA_LIBS += -lviaXvMC -lXvMC:' \
			-i 'settings.pro' || die "disable VLD XvMC sed failed"
	fi

	if use opengl ; then
		sed -e 's:#DEFINES += USING_OPENGL_VSYNC:DEFINES += USING_OPENGL_VSYNC:' \
			-e 's:#EXTRA_LIBS += -lGL:EXTRA_LIBS += -lGL:' \
			-e 's:#CONFIG += using_opengl:CONFIG += using_opengl:' \
			-i 'settings.pro' || die "enable opengl sed failed"
	fi

	if use ieee1394 ; then
		sed -e 's:#CONFIG += using_firewire:CONFIG += using_firewire:' \
			-e 's:#DEFINES += USING_FIREWIRE:DEFINES += USING_FIREWIRE:' \
			-e 's:#EXTRA_LIBS += -lraw1394 -liec61883:EXTRA_LIBS += -lraw1394 -liec61883:' \
			-i 'settings.pro' || die "failed to enable firewire support"
	fi

	#Gentoo X ebuilds always have XrandrX
	sed -e 's:#CONFIG += using_xrandr:CONFIG += using_xrandr:' \
		-e 's:#DEFINES += USING_XRANDR:DEFINES += USING_XRANDR:' \
		-i 'settings.pro' || die "enable xrandr sed failed"
}

src_unpack() {
	# Fix bugs 40964 and 42943.
	filter-flags -fforce-addr -fPIC

	# fix bug 67832, 81610, etc
	is-flag "-march=pentium4" && replace-flags "-O3" "-O2"
	is-flag "-march=pentium4" && replace-flags "-0s" "-O2"
	is-flag "-march=athlon-xp" && replace-flags "-O3" "-O2"

	myth_src_unpack || die "unpack failed"
}

src_compile() {
	export QMAKESPEC="linux-g++"

	econf || die
	sed -i -e "s:OPTFLAGS=.*:OPTFLAGS=${CFLAGS}:g" config.mak

	qmake -o "Makefile" "mythtv.pro"
	make qmake || die
	emake -C libs/libavcodec || die
	emake -C libs/libavformat || die
	emake -C libs/libmythsamplerate || die
	emake -C libs/libmythsoundtouch || die
	emake -C libs/libmythmpeg2 || die
	emake -C libs/libmyth || die
	emake -C libs/libmythtv || die
	emake -C libs || die
	emake || die
}

src_install() {
	myth_src_install || die "install failed"

	dodoc keys.txt docs/*.{txt,pdf}
	dohtml docs/*.html
}
