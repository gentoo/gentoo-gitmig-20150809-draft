# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/freevo/freevo-1.4.1.ebuild,v 1.1 2004/02/06 14:33:23 max Exp $

inherit distutils

IUSE="matrox dvd encode lirc X nls"

DESCRIPTION="Digital video jukebox (PVR, DVR)."
HOMEPAGE="http://www.freevo.org/"
SRC_URI="mirror://sourceforge/${PN}/${P/_/}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="${DEPEND}
	>=dev-python/pygame-1.5.6
	>=dev-python/Imaging-1.1.3
	>=dev-python/pyxml-0.8.2
	>=dev-python/twisted-1.0.7
	>=dev-python/mmpython-0.3
	>=media-video/mplayer-0.92
	>=media-libs/freetype-2.1.4
	>=media-libs/libsdl-1.2.5
	>=sys-apps/sed-4
	dvd? ( >=media-video/xine-ui-0.9.22 )
	encode? ( >=media-sound/cdparanoia-3.9.8 >=media-sound/lame-3.93.1 )
	matrox? ( >=media-video/matroxset-0.3 )
	lirc? ( app-misc/lirc >=dev-python/pylirc-0.0.3 )
	X? ( virtual/x11 )"

S="${WORKDIR}/${P/_/}"

src_compile() {
	local myconf

	if [ "`/bin/ls -l /etc/localtime | grep Europe`" ] ; then
		myconf="${myconf} --tv=pal"
	fi
	if [ "`use matrox`" ] ; then
		myconf="${myconf} --geometry=768x576 --display=mga"
	elif [ "`use X`" ] ; then
		myconf="${myconf} --geometry=800x600 --display=x11"
	else
		myconf="${myconf} --geometry=800x600 --display=fbdev"
	fi

	sed -e "s:/etc/freevo/freevo.conf:${T}/freevo.conf:" \
		-i "${S}/src/setup_freevo.py" || die "sed failed"

	"${S}/freevo" setup ${myconf} || die "configure problem"

	sed -e "s:${T}/freevo.conf:/etc/freevo/freevo.conf:" \
		-i "${S}/src/setup_freevo.py" || die "sed failed"
}

src_install() {
	distutils_src_install

	insinto /etc/freevo
	doins "${T}/freevo.conf"
	newins local_conf.py.example local_conf.py

	exeinto /etc/init.d
	newexe "${FILESDIR}/freevo.rc6" freevo
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
}
