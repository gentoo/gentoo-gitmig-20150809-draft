# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/mythtv/mythtv-0.13-r1.ebuild,v 1.2 2004/01/15 18:03:59 max Exp $

inherit flag-o-matic

DESCRIPTION="Homebrew PVR project."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="alsa lcd lirc nvidia"

DEPEND="virtual/x11
	>=x11-libs/qt-3.1
	>=media-sound/lame-3.93.1
	>=media-libs/freetype-2.0
	>=media-tv/xmltv-0.5.16
	>=sys-apps/sed-4
	alsa? ( media-libs/alsa-lib )
	lcd? ( app-misc/lcdproc )
	lirc? ( app-misc/lirc )
	nvidia? ( media-video/nvidia-glx )"
	#dvb? ( media-libs/libdvb )

RDEPEND="${DEPEND}
	!media-tv/mythfrontend"

pkg_setup() {
	local qt_use="$(</var/db/pkg/`best_version x11-libs/qt`/USE)"
	if [ ! "`has mysql ${qt_use}`" ] ; then
		eerror "Qt is missing MySQL support. Please add"
		eerror "'mysql' to your USE flags, and re-emerge Qt."
		die "Qt needs mysql support"
	fi

	return 0
}

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/tvformat.fix.0.13.diff

	for i in `grep -lr "usr/local" "${S}"` ; do
		sed -e "s:usr/local:usr:g" -i "${i}" || die "sed failed"
	done
}

src_compile() {
	local cpu="`get-flag march || get-flag mcpu`"
	if [ "${cpu}" ] ; then
		sed -e "s:pentiumpro:${cpu}:g" -i "settings.pro" || die "sed failed"
	fi

	if [ "`use alsa`" ] ; then
		sed -e "s:#CONFIG += using_alsa:CONFIG += using_alsa:" \
			-e "s:#ALSA_LIBS = -lasound:ALSA_LIBS = -lasound:" \
			-i "settings.pro" || die "enable alsa sed failed"
	fi
	# Not quite ready for prime time.
	#if [ "`use dvb`" ] ; then
	#	sed -e "s:#CONFIG += using_dvb:CONFIG += using_dvb:" \
	#		-e "s:#DEFINES += USING_DVB:DEFINES += USING_DVB:" \
	#		-e "s:#INCLUDEPATH += /usr/src:INCLUDEPATH += /usr:" \
	#		-i "settings.pro" || die "enable dvb sed failed"
	#fi
	if [ "`use lcd`" ] ; then
		sed -e "s:#DEFINES += LCD_DEVICE:DEFINES += LCD_DEVICE:" \
			-i "settings.pro" || die "enable lcd sed failed"
	fi
	if [ "`use lirc`" ] ; then
		sed -e "s:#CONFIG += using_lirc:CONFIG += using_lirc:" \
			-e "s:#LIRC_LIBS = -llirc_client:LIRC_LIBS = -llirc_client:" \
			-i "settings.pro" || die "enable lirc sed failed"
	fi
	if [ "`use nvidia`" ] ; then
		sed -e "s:#CONFIG += using_xvmc:CONFIG += using_xvmc:" \
			-e "s:#EXTRA_LIBS += -lXvMCNVIDIA:EXTRA_LIBS += -lXvMCNVIDIA:" \
			-i "settings.pro" || die "enable xvmc sed failed"
	fi
	# Needs a VIA supported kernel driver.
	#if [ "`use via`" ] ; then
	#	sed -e "s:#CONFIG += using_via:CONFIG += using_via:"
	#		-e "s:#EXTRA_LIBS += -lddmpeg:EXTRA_LIBS += -lddmpeg:"
	#		-i "settings.pro" || die "enable lirc sed failed"
	#fi

	qmake -o "Makefile" "${PN}.pro"

	econf
	make || die "compile problem"
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
	einfo "then run xmltv's grabber to configure your channels."
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
	ewarn "This part is important as there might be database changes"
	ewarn "which need to be performed or this package will not work"
	ewarn "properly."
	echo
}
