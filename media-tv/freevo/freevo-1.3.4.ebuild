# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/freevo/freevo-1.3.4.ebuild,v 1.1 2003/09/10 18:57:14 max Exp $

DESCRIPTION="Digital video jukebox (PVR, DVR)."
HOMEPAGE="http://www.freevo.org/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="matrox dvd encode lirc X"

DEPEND=">=dev-python/pygame-1.5.5
	>=dev-python/Imaging-1.1.3
	>=dev-python/pyxml-0.8.1
	>=dev-python/twisted-1.0.6
	>=dev-python/mmpython-0.1
	>=media-video/mplayer-0.90
	>=media-libs/freetype-2.1.4
	>=media-libs/libsdl-1.2.5
	>=media-tv/xmltv-0.5.16
	>=sys-apps/sed-4
	dvd? ( >=media-video/xine-ui-0.9.21 )
	encode? ( >=media-sound/cdparanoia-3.9.8 >=media-sound/lame-3.93.1 )
	lirc? ( app-misc/lirc >=dev-python/pylirc-0.0.3 )
	X? ( virtual/x11 )"

src_compile() {
	local myconf

	if [ "`/bin/ls -l /etc/localtime | grep Europe`" ] ; then
		myconf="$myconf --tv=pal"
	fi
	if [ "`use matrox`" ] ; then
		myconf="--geometry=768x576 --display=mga"
	else
		myconf="--geometry=800x600 --display=sdl"
	fi
	if [ ! "`use X`" ] ; then
		sed -e 's:\(all.*\)freevo_xwin:\1:' -i Makefile
	fi

	emake || die "compile problem"
	./freevo setup ${myconf} || die "configure problem"
}

src_install() {
	epatch "${FILESDIR}/freevo-setup.patch"
	einstall PREFIX="${D}/opt/freevo" \
		LOGDIR="${D}/var/log/freevo" \
		CACHEDIR="${D}/var/cache/freevo"

	insinto /etc/freevo
	doins freevo.conf local_conf.py

	exeinto /etc/init.d
	newexe "${FILESDIR}/freevo-record.rc6" freevo-record
	newexe "${FILESDIR}/freevo-web.rc6" freevo-web
	if [ "`use matrox`" ] ; then
		newexe "${FILESDIR}/freevo.rc6" freevo
	fi

	dohtml Docs/html/*
	dodoc BUGS COPYING ChangeLog FAQ INSTALL README TODO VERSION Docs/{CREDITS,NOTES}
	cp -r Docs/freevo_howto "${D}/usr/share/doc/${PF}/howto"

	cd "${D}/opt/freevo"
	rm -rf BUGS COPYING ChangeLog FAQ INSTALL README TODO VERSION Docs \
		configure setup_build.py runtime freevo.conf local_conf.py \
		*.c *.h Makefile fbcon/Makefile fbcon/vtrelease.c \
		contrib boot WIP freevo_setup~ freevo~
}

pkg_postinst() {
	einfo "Please check /etc/freevo/freevo.conf and"
	einfo "/etc/freevo/local_conf.py before starting Freevo."
	einfo "To rebuild freevo.conf with different parameters,"
	einfo "please run /opt/freevo/freevo setup"
	echo

	if [ -e /etc/freevo/freevo_config.py ] ; then
		ewarn "Please remove /etc/freevo/freevo_config.py"
	fi
}
