# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/freevo/freevo-1.5.4-r1.ebuild,v 1.1 2006/10/19 16:48:32 mattepiu Exp $

inherit distutils

IUSE="matrox dvd encode lirc X nls"
DESCRIPTION="Digital video jukebox (PVR, DVR)."
HOMEPAGE="http://www.freevo.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=dev-python/pygame-1.5.6
	>=dev-python/imaging-1.1.3
	>=dev-python/pyxml-0.8.2
	>=dev-python/twisted-2
	>=dev-python/twisted-web-0.5.0-r1
	>=dev-python/mmpython-0.4.5
	>=media-video/mplayer-0.92
	>=media-libs/freetype-2.1.4
	>=media-libs/libsdl-1.2.5
	>=sys-apps/sed-4
	dvd? ( >=media-video/xine-ui-0.9.22 >=media-video/lsdvd-0.10 )
	encode? ( >=media-sound/cdparanoia-3.9.8 >=media-sound/lame-3.93.1 )
	matrox? ( >=media-video/matroxset-0.3 )
	lirc? ( app-misc/lirc >=dev-python/pylirc-0.0.3 )"

src_unpack() {
	unpack ${A}
	cp "${FILESDIR}/freevo.rc6" "${WORKDIR}/"
	if use X ; then
		sed -e 's/lircd/lircd xdm/g' "${WORKDIR}/freevo.rc6" > "${WORKDIR}/freevo.rc6b"
	else
		sed -e 's/lircd/lircd local/g' "${WORKDIR}/freevo.rc6" > "${WORKDIR}/freevo.rc6b"
	fi
}

src_install() {
	distutils_src_install

	insinto /etc/freevo
	doins "${T}/freevo.conf"
	newins local_conf.py.example local_conf.py

	if [ "${PROFILE_ARCH}" == "xbox" ]; then
		sed -i -e "s/# MPLAYER_AO_DEV.*/MPLAYER_AO_DEV='alsa1x'/" ${D}/etc/freevo/local_conf.py
		newins ${FILESDIR}/xbox-lircrc lircrc
	fi

	if use X; then
		echo "#!/bin/bash" > freevo
		echo "/usr/bin/freevoboot startx" >> freevo
		exeinto /etc/X11/Sessions/
		doexe freevo

		KDFREEVO=`kde-config --prefix`
		if [ "x$KDFREEVO" != "x" ]; then
			FREEVOSESSION=`grep ^SessionsDirs= ${KDFREEVO}/share/config/kdm/kdmrc | cut -d= -f 2 | cut -d: -f1`
			if [ "x${FREEVOSESSION}" != "x" ]; then
				insinto ${FREEVOSESSION}
				doins ${FILESDIR}/freevo.desktop freevo.desktop
			fi
		fi

		insinto /etc/X11/dm/Sessions
		doins ${FILESDIR}/freevo.desktop freevo.desktop
	fi

	exeinto /usr/bin
	newexe "${WORKDIR}/freevo.boot" freevoboot
	insinto /etc/conf.d
	newins "${FILESDIR}/freevo.conf" freevo

	rm -rf "${D}/usr/share/doc"
	newdoc Docs/README README.docs
	dodoc BUGS COPYING ChangeLog FAQ INSTALL PKG-INFO README TODO \
		Docs/{CREDITS,NOTES,plugins/*.txt}
	cp -r Docs/{installation,plugin_writing} "${D}/usr/share/doc/${PF}"

	use nls || rm -rf ${D}/usr/share/locale
}

pkg_postinst() {
	einfo "If you want to schedule programs, emerge xmltv now."
	echo

	einfo "Please check /etc/freevo/freevo.conf and"
	einfo "/etc/freevo/local_conf.py before starting Freevo."
	einfo "To rebuild freevo.conf with different parameters,"
	einfo "please run:"
	einfo "    freevo setup"
	echo

	if [ -e "${ROOT}/etc/init.d/freevo" ] ; then
		ewarn "Please remove ${ROOT}/etc/init.d/freevo because is no longer used"
		ewarn "and runnining freevo as root could be a security risk"
	fi
	echo
	ewarn "Freevo starting for freevo only system is changed, cause"
	ewarn "initscript would run it as root and this may cause unsecurity."
	ewarn "That is now substituted with freevoboot, a wrapper to be runned"
	ewarn "as user. Configuration is still in /etc/conf.d/freevo"
	echo
	if use X ; then
		ewarn "If you're using a Freevo-only system with X, you'll need"
		ewarn " to setup the autologin (as user) and choose freevo as"
		ewarn "default session. If you need to run recordserver/webserver"
		ewarn "at boot, please use /etc/conf.d/freevo as always."
		echo
		ewarn "Should you decide to personalize your freevo.desktop"
		ewarn "session, keep inside /usr/bin/freevoboot startx (wrapper)."
		echo
	else
		ewarn "Freevo initscript is changed and should not be run as root"
		echo
		ewarn "If you want Freevo to start automatically,you'll need"
		ewarn "to follow instructions at :"
		ewarn "http://freevo.sourceforge.net/cgi-bin/doc/BootFreevo"
		echo
		ewarn "*NOTE: you can use mingetty or provide a login"
		ewarn "program for getty to autologin as limited privileges user"
		ewarn "a tutorial for getty is at:"
		ewarn "http://ubuntuforums.org/showthread.php?t=152274"
		echo
		ewarn "Sorry for the disadvantage, this is done for bug #150568."
		echo
	fi

	if [ -e "${ROOT}/etc/init.d/freevo" ] ; then
		ewarn "Please remove ${ROOT}/etc/init.d/freevo as is a security"
		ewarn "threat. To set autostart read above."
	fi

	if [ -e "${ROOT}/opt/freevo" ] ; then
		ewarn "Please remove ${ROOT}/opt/freevo because it is no longer used."
	fi
	if [ -e "${ROOT}/etc/freevo/freevo_config.py" ] ; then
		ewarn "Please remove ${ROOT}/etc/freevo/freevo_config.py."
	fi
	if [ -e "${ROOT}/etc/init.d/freevo-record" ] ; then
		ewarn "Please remove ${ROOT}/etc/init.d/freevo-record"
	fi
	if [ -e "${ROOT}/etc/init.d/freevo-web" ] ; then
		ewarn "Please remove ${ROOT}/etc/init.d/freevo-web"
	fi

	local myconf
	if [ "`/bin/ls -l /etc/localtime | grep -e "Europe\|GMT"`" ] ; then
		myconf="${myconf} --tv=pal"
	fi
	if [ "${PROFILE_ARCH}" == "xbox" ]; then
		myconf="${myconf} --geometry=640x480 --display=x11"
	elif use matrox ; then
		myconf="${myconf} --geometry=768x576 --display=mga"
	elif use X ; then
		myconf="${myconf} --geometry=800x600 --display=x11"
	else
		myconf="${myconf} --geometry=800x600 --display=fbdev"
	fi

	"/usr/bin/freevo" setup ${myconf} || die "configure problem"
}
