# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/mythfrontend/mythfrontend-0.12.ebuild,v 1.3 2004/01/15 18:03:50 max Exp $

inherit flag-o-matic

DESCRIPTION="Homebrew PVR project frontend."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/mythtv-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="alsa lcd lirc nvidia"

DEPEND="virtual/x11
	>=x11-libs/qt-3.1
	>=media-sound/lame-3.93.1
	>=media-libs/freetype-2.0
	>=sys-apps/sed-4
	alsa? ( media-libs/alsa-lib )
	lcd? ( app-misc/lcdproc )
	lirc? ( app-misc/lirc )
	nvidia? ( media-video/nvidia-glx )"

RDEPEND="${DEPEND}
	!media-tv/mythtv"

S="${WORKDIR}/mythtv-${PV}"

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
	unpack ${A}

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
			-e "s:#EXTRA_LIBS += -lasound:EXTRA_LIBS += -lasound:" \
			-i "settings.pro" || die "enable alsa sed failed"
	fi
	if [ "`use lcd`" ] ; then
		sed -e "s:#DEFINES += LCD_DEVICE:DEFINES += LCD_DEVICE:" \
			-i "settings.pro" || die "enable lcd sed failed"
	fi
	if [ "`use lirc`" ] ; then
		sed -e "s:#CONFIG += using_lirc:CONFIG += using_lirc:" \
			-e "s:#EXTRA_LIBS += -llirc_client:EXTRA_LIBS += -llirc_client:" \
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

	qmake -o "Makefile" "mythtv.pro"

	econf
	make || die "compile problem"
}

src_install() {
	einstall INSTALL_ROOT="${D}"

	dodir /etc/mythtv
	mv "${D}/usr/share/mythtv/mysql.txt" "${D}/etc/mythtv"
	dosym /etc/mythtv/mysql.txt /usr/share/mythtv/mysql.txt

	rm -rf "${D}"/usr/bin/myth{backend,commflag,filldatabase,transcode} \
		"${D}/usr/share/mythtv/setup.xml"

	dodoc AUTHORS COPYING FAQ README UPGRADING keys.txt docs/*.{txt,pdf}
	dohtml docs/*.html
}
