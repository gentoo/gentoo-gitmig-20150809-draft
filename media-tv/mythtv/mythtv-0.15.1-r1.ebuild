# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/mythtv/mythtv-0.15.1-r1.ebuild,v 1.6 2004/07/14 08:59:45 aliz Exp $

inherit flag-o-matic eutils gcc

DESCRIPTION="Homebrew PVR project."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="alsa arts dvb directfb lcd lirc nvidia cle266 opengl X xv debug"

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
	opengl? ( >=x11-base/opengl-update-1.7 )
	|| ( >=net-misc/wget-1.9.1 >=media-tv/xmltv-0.5.34 )"

RDEPEND="${DEPEND}
	!media-tv/mythfrontend"

pkg_setup() {
	if use X; then QTP=x11-libs/qt; else QTP=x11-libs/qt-embedded; fi
	local qt_use="$(</var/db/pkg/`best_version ${QTP}`/USE)"
	if [ ! "`has mysql ${qt_use}`" ] ; then
		eerror "Qt is missing MySQL support. Please add"
		eerror "'mysql' to your USE flags, and re-emerge Qt."
		die "Qt needs MySQL support"
	fi
	if use opengl ; then
		local gl_implementation="$( opengl-update --get-implementation )"
		if [ "$gl_implementation" == "xfree" ] || [ "$gl_implementation" == "xorg-x11" ] ; then
			return 0
		else
			eerror "OpenGL implementation must be set to either xfree or xorg-x11 to allow compilation."
			eerror "to change opengl implemantation use opengl-update <your xserver>."
			eerror "After mythtv has been merged you can switch back to the preferred implementation.."
			die "Incompatible OpenGL implementation."
		fi
	fi
	return 0
}

src_unpack() {
	unpack ${A} && cd ${S}

	for i in `grep -lr "usr/local" "${S}"` ; do
		sed -e "s:usr/local:usr:g" -i "${i}" || die "sed failed"
	done

	use directfb && epatch ${FILESDIR}/mythtv-0.15-directfb.patch

	# Applies patch for gcc-3.4.0 closing bug #52819
	if [ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "4" ]; then
		epatch ${FILESDIR}/gcc-3.4-fix.patch
	fi
}

src_compile() {
	# Fix bugs 40964 and 42943.
	filter-flags -fforce-addr -fPIC

	if [ "${ARCH}" == "amd64" ]; then
		sed -e "s:-march=pentiumpro::" -e "/DEFINES += MMX/d" -i settings.pro
	else
		local cpu="`get-flag march || get-flag mcpu`"
		if [ "${cpu}" ] ; then
			sed -e "s:pentiumpro:${cpu}:g" -i "settings.pro" || die "sed failed"
		fi
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
	if use directfb ; then
		sed -e 's:#CONFIG += using_directfb:CONFIG += using_directfb:' \
			-e 's:#EXTRA_LIBS += `directfb:EXTRA_LIBS += `directfb:' \
			-e 's:#QMAKE_CXXFLAGS += `directfb:QMAKE_CXXFLAGS += `directfb:' \
			-i 'settings.pro' || die "enable directfb sed failed"
	fi
	if use dvb ; then
		sed -e 's:#CONFIG += using_dvb:CONFIG += using_dvb:' \
			-e 's:#DEFINES += USING_DVB:DEFINES += USING_DVB:' \
			-e 's:#INCLUDEPATH += /usr/src/.*:INCLUDEPATH += /usr/include:' \
			-i 'settings.pro' || die "enable dvb sed failed"
	fi
	if use lcd ; then
		sed -e 's:#DEFINES += LCD_DEVICE:DEFINES += LCD_DEVICE:' \
			-i 'settings.pro' || die "enable lcd sed failed"
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
	if use opengl ; then
		sed -e 's:#DEFINES += USING_OPENGL_VSYNC:DEFINES += USING_OPENGL_VSYNC:' \
			-e 's:#EXTRA_LIBS += -lGL -lGLU:EXTRA_LIBS += -lGL -lGLU:' \
			-i 'settings.pro' || die "enable opengl sed failed"
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

	if use debug ; then
		sed -e 's:#CONFIG += debug:CONFIG += debug:' \
			-e 's:CONFIG += release:#CONFIG += release:' \
		-i 'settings.pro' || die "enable debug failed"
	fi

	sed -i -e "s:-O3::g" -e "s:-fomit-frame-pointer::g" settings.pro

	export QMAKESPEC="linux-g++"
	qmake -o "Makefile" "${PN}.pro"

	econf || die "econf failed"
	sed -i -e "s:OPTFLAGS=.*:OPTFLAGS=${CFLAGS}:g" config.mak
	# enable exceptions if they are disabled (qt-e).
	# this might not work.. if so, rebuild qt-e with rtti and exceptions
	sed -i -e "s:-fno-exceptions:-fexceptions:g" programs/mythfilldatabase/Makefile
	emake -j1 || die "compile problem"
}

src_install() {
	einstall INSTALL_ROOT="${D}"
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

	dodoc AUTHORS COPYING FAQ README UPGRADING keys.txt docs/*.{txt,pdf}
	dohtml docs/*.html

	keepdir /var/{log,run}/mythtv
}

pkg_postinst() {
	ewarn "Please note that /usr/share/mythtv/setup has been moved"
	ewarn "to /usr/bin/mythsetup"
	echo

	einfo "If this is the first time you install MythTV,"
	einfo "you need to add /usr/share/mythtv/database/mc.sql"
	einfo "to your mysql database."
	einfo
	einfo "You might run 'mysql < /usr/share/mythtv/database/mc.sql'"
	einfo
	einfo "Next, you need to run the mythsetup program."
	einfo "It will ask you some questions about your hardware, and"
	einfo "then run XMLTV's grabber to configure your channels."
	einfo
	einfo "Once you have configured your database, you can run"
	einfo "/usr/bin/mythfilldatabase to populate the schedule"
	einfo "or copy /usr/share/mythtv/mythfilldatabase.cron to"
	einfo "/etc/cron.daily for this to happen automatically."
	einfo
	einfo "If you're upgrading from an older version and for more"
	einfo "setup and usage instructions, please refer to:"
	einfo "   /usr/share/doc/${PF}/README.gz"
	einfo "   /usr/share/doc/${PF}/UPGRADING.gz"
	echo
	einfo "You need to emerge xmltv manually since it is no longer needed"
	einfo "if the internal DataDirect implementation is to be used."
}
