# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/mythtv/mythtv-0.16.ebuild,v 1.9 2004/12/05 00:46:13 iggy Exp $

inherit myth flag-o-matic eutils

DESCRIPTION="Homebrew PVR project"
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="alsa arts dvb directfb lcd lirc nvidia cle266 opengl X xv oss debug mmx nls"

DEPEND=">=media-libs/freetype-2.0
	>=media-sound/lame-3.93.1
	X? ( >=x11-libs/qt-3.1 )
	directfb? ( dev-libs/DirectFB >=x11-libs/qt-embedded-3.1 )
	dev-db/mysql
	alsa? ( >=media-libs/alsa-lib-0.9 )
	>=sys-apps/sed-4
	arts? ( kde-base/arts )
	dvb? ( media-libs/libdvb )
	lcd? ( app-misc/lcdproc )
	lirc? ( app-misc/lirc )
	nvidia? ( media-video/nvidia-glx )
	cle266? ( media-libs/libddmpeg )
	|| ( >=net-misc/wget-1.9.1 >=media-tv/xmltv-0.5.34 )"

RDEPEND="${DEPEND}
	!media-tv/mythfrontend"

pkg_setup() {
	if use X; then
		QTP=x11-libs/qt
	elif use directfb; then
		QTP=x11-libs/qt-embedded
	else
		eerror "You must have either X or directfb in USE"
		die "No QT library selected"
	fi

	local qt_use="$(</var/db/pkg/`best_version ${QTP}`/USE)"
	if ! has mysql ${qt_use} ; then
		eerror "Qt is missing MySQL support. Please add"
		eerror "'mysql' to your USE flags, and re-emerge Qt."
		die "Qt needs MySQL support"
	fi

	if ! use oss && ! use alsa && ! use arts ; then
		eerror "You must have one of oss alsa or arts enabled"
		die "No audio selected"
	fi
	return 0
}

setup_pro() {
	if [ "${ARCH}" == "amd64" ] || ! use mmx; then
		sed -i settings.pro \
			-e "s:DEFINES += MMX:DEFINES -= MMX:"
	fi

	if ! use X ; then
		sed -e 's:CONFIG += using_x11:#CONFIG += using_x11:' \
			-i 'settings.pro' || die "disable x11 failed"
	fi

	if ! use xv ; then
		sed -e 's:CONFIG += using_xv:#CONFIG += using_xv:' \
			-e 's:EXTRA_LIBS += -L/usr/X11:#EXTRA_LIBS += -L/usr/X11:' \
			-i 'settings.pro' || die "disable xv failed"
	fi

	if use lcd ; then
		sed -e 's:#DEFINES += LCD_DEVICE:DEFINES += LCD_DEVICE:' \
			-i 'settings.pro' || die "enable lcd sed failed"
	fi

	if ! use oss ; then
		sed -e 's:CONFIG += using_oss:#CONFIG += using_oss:' \
			-e 's:DEFINES += USING_OSS:#DEFINES += USING_OSS:' \
			-i 'settings.pro' || die "disable oss failed"
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

	if use cle266 ; then
		sed -e 's:#CONFIG += using_viahwslice:CONFIG += using_viahwslice:' \
			-e 's:#DEFINES += USING_VIASLICE:DEFINES += USING_VIASLICE:' \
			-e 's:#EXTRA_LIBS += -lddmpeg:EXTRA_LIBS += -lddmpeg:' \
			-i 'settings.pro' || die "enable cle266 sed failed"
	fi

	if use directfb ; then
		sed -e 's:#CONFIG += using_directfb:CONFIG += using_directfb:' \
			-e 's:#EXTRA_LIBS += `directfb:EXTRA_LIBS += `directfb:' \
			-e 's:#QMAKE_CXXFLAGS += `directfb:QMAKE_CXXFLAGS += `directfb:' \
			-i 'settings.pro' || die "enable directfb sed failed"
	fi
	if use opengl ; then
		sed -e 's:#DEFINES += USING_OPENGL_VSYNC:DEFINES += USING_OPENGL_VSYNC:' \
			-e 's:#EXTRA_LIBS += -lGL:EXTRA_LIBS += -lGL:' \
			-e 's:#CONFIG += using_opengl:CONFIG += using_opengl:' \
			-i 'settings.pro' || die "enable opengl sed failed"
	fi
}

src_unpack() {
	# Fix bugs 40964 and 42943.
	filter-flags -fforce-addr -fPIC

	myth_src_unpack

	epatch ${FILESDIR}/${P}-cx88.patch
	sed -i '32i #include <cmath>' ${S}/libs/libmythtv/dvbdiseqc.cpp
}


src_compile() {
	export QMAKESPEC="linux-g++"

	econf || die
	sed -i -e "s:OPTFLAGS=.*:OPTFLAGS=${CFLAGS}:g" config.mak

	qmake -o "Makefile" "${PN}.pro"
	make qmake || die
	emake -C libs/libavcodec || die
	emake -C libs/libavformat || die
	emake -C libs/libmyth || die
	emake -C libs/libmythtv || die
	emake -C libs || die
	emake || die
}

src_install() {
	myth_src_install
	newbin "setup/setup" "mythsetup"

	dodir /etc/mythtv
	mv "${D}/usr/share/mythtv/mysql.txt" "${D}/etc/mythtv"
	dosym /etc/mythtv/mysql.txt /usr/share/mythtv/mysql.txt

	insinto /usr/share/mythtv/database
	doins database/*

	exeinto /usr/share/mythtv
	doexe "${FILESDIR}/mythfilldatabase.cron"

	exeinto /etc/init.d
	newexe "${FILESDIR}/mythbackend.rc6" mythbackend
	insinto /etc/conf.d
	newins "${FILESDIR}/mythbackend.conf" mythbackend

	dodoc keys.txt docs/*.{txt,pdf}
	dohtml docs/*.html

	keepdir /var/{log,run}/mythtv
}
