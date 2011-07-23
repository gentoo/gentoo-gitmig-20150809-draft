# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/adobe-flash/adobe-flash-10.3.181.34.ebuild,v 1.4 2011/07/23 11:29:07 maekke Exp $

EAPI=4
inherit nsplugins rpm multilib toolchain-funcs

MY_32B_URI="http://fpdownload.macromedia.com/get/flashplayer/current/flash-plugin-${PV}-release.i386.rpm"

DESCRIPTION="Adobe Flash Player"
SRC_URI="${MY_32B_URI}"
HOMEPAGE="http://www.adobe.com/flashplayer"
IUSE="vdpau kde"
SLOT="0"

KEYWORDS="-* amd64 x86"
LICENSE="AdobeFlash-10.3"
RESTRICT="strip mirror"

S="${WORKDIR}"

NATIVE_DEPS="x11-libs/gtk+:2
	media-libs/fontconfig
	dev-libs/nss
	net-misc/curl
	vdpau? ( x11-libs/libvdpau )
	kde? ( kde-base/kcmshell )
	>=sys-libs/glibc-2.4"

EMUL_DEPS="vdpau? ( >=app-emulation/emul-linux-x86-xlibs-20110129 )
	>=app-emulation/emul-linux-x86-gtklibs-20100409-r1
	app-emulation/emul-linux-x86-soundlibs"

DEPEND="amd64? ( www-plugins/nspluginwrapper )"
RDEPEND="x86? ( $NATIVE_DEPS )
	amd64? ( $EMUL_DEPS )
	|| ( media-fonts/liberation-fonts media-fonts/corefonts )
	${DEPEND}"

# Where should this all go? (Bug #328639)
INSTALL_BASE="opt/Adobe/flash-player"
INSTALL_BASE32="${INSTALL_BASE}32"

# Ignore QA warnings in these binary closed-source libraries, since we can't fix
# them:
QA_EXECSTACK="${INSTALL_BASE}/plugin/libflashplayer.so
	${INSTALL_BASE32}/plugin/libflashplayer.so"

QA_DT_HASH="${INSTALL_BASE}/plugin/libflashplayer.so
	${INSTALL_BASE32}/plugin/libflashplayer.so"

src_install() {
	if use amd64; then
		local oldabi="${ABI}"
		ABI="x86"
		BASE=${INSTALL_BASE32}
	else
		BASE=${INSTALL_BASE}
	fi

	# The plugin itself
	exeinto /${BASE}/plugin
	doexe usr/lib/flash-plugin/libflashplayer.so
	doexe usr/lib/flash-plugin/homecleanup
	inst_plugin /${BASE}/plugin/libflashplayer.so

	# The optional KDE4 KCM plugin
	if use kde && ! use amd64; then
		exeinto /usr/$(get_libdir)/kde4/
		doexe usr/$(get_libdir)/kde4/kcm_adobe_flash_player.so
		insinto /usr/share/kde4/services
		doins usr/share/kde4/services/kcm_adobe_flash_player.desktop
	else
		# No KDE applet, so allow the GTK utility to show up in KDE:
		sed -i usr/share/applications/flash-player-properties.desktop \
			-e "/^NotShowIn=KDE;/d" || die "sed of .desktop file failed"
	fi

	# The userland 'properties' standalone app:
	exeinto /${BASE}/bin
	doexe usr/bin/flash-player-properties
	for icon in $(find usr/share/icons/ -name '*.png'); do
		insinto /$(dirname $icon)
		doins $icon
	done
	elog "Done with icons."
	insinto usr/share/applications
	sed -i usr/share/applications/flash-player-properties.desktop \
		-e "s:^Exec=:Exec=/${BASE}/bin/:" || die "sed of .desktop file failed"
	doins usr/share/applications/flash-player-properties.desktop

	dodoc "usr/lib/flash-plugin/README"
	dodoc "usr/share/doc/flash-plugin-${PV}/readme.txt"

	if use amd64; then
		ABI="${oldabi}"
	fi

	# The magic config file!
	insinto "/etc/adobe"
	doins "${FILESDIR}/mms.cfg"
}

pkg_postinst() {
	if use amd64; then
		elog "Adobe has no stable 64-bit native version at this time."
		#elog "The beta"
		#elog "64-bit native release (codenamed \"square\") is installed as part"
		#elog "of the unstable testing version of this package:"
		#elog "  ${CATEGORY}/${P}_p...."
		elog
		if has_version 'www-plugins/nspluginwrapper'; then
			elog "nspluginwrapper detected: Installing plugin wrapper"
			local oldabi="${ABI}"
			ABI="x86"
			local FLASH_SOURCE="${ROOT}/${INSTALL_BASE32}/plugin/libflashplayer.so"
			nspluginwrapper -i "${FLASH_SOURCE}"
			ABI="${oldabi}"
			elog
		else
			elog "To use the 32-bit flash player in a native 64-bit firefox,"
			elog "you must install www-plugins/nspluginwrapper."
			elog
		fi
	fi

	ewarn "Flash player is closed-source, with a long history of security"
	ewarn "issues.  Please consider only running flash applets you know to"
	ewarn "be safe.  The 'flashblock' extension may help for mozilla users:"
	ewarn "  https://addons.mozilla.org/en-US/firefox/addon/433"
}
