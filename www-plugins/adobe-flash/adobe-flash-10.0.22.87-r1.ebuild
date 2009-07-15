# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/adobe-flash/adobe-flash-10.0.22.87-r1.ebuild,v 1.1 2009/07/15 13:39:03 lack Exp $

EAPI=1
inherit nsplugins rpm multilib

MY_32B_URI="http://fpdownload.macromedia.com/get/flashplayer/current/flash-plugin-${PV}-release.i386.rpm"
MY_64B_URI="http://download.macromedia.com/pub/labs/flashplayer10/libflashplayer-${PV}.linux-x86_64.so.tar.gz"

DESCRIPTION="Adobe Flash Player"
SRC_URI="x86? ( ${MY_32B_URI} )
amd64? (
	multilib? (
		32bit? ( ${MY_32B_URI} mirror://gentoo/flash-libcompat-0.2.tar.bz2 )
		64bit? ( ${MY_64B_URI} )
	)
	!multilib? ( ${MY_64B_URI} )
)"
HOMEPAGE="http://www.adobe.com/"
IUSE="multilib +32bit +64bit"
SLOT="0"

KEYWORDS="-* ~amd64 ~x86"
LICENSE="AdobeFlash-10"
RESTRICT="strip mirror"

S="${WORKDIR}"

NATIVE_DEPS="x11-libs/gtk+:2
	media-libs/fontconfig
	dev-libs/nss
	net-misc/curl
	>=sys-libs/glibc-2.4
	|| ( media-fonts/freefont-ttf media-fonts/corefonts )"

EMUL_DEPS="app-emulation/emul-linux-x86-baselibs
	app-emulation/emul-linux-x86-gtklibs
	app-emulation/emul-linux-x86-soundlibs
	app-emulation/emul-linux-x86-xlibs"

RDEPEND="x86? ( $NATIVE_DEPS )
	amd64? (
		multilib? (
			64bit? ( $NATIVE_DEPS )
			32bit? ( $EMUL_DEPS )
		)
		!multilib? ( $NATIVE_DEPS )
	)"

# Our new flash-libcompat suffers from the same EXESTACK problem as libcrypto
# from app-text/acroread, so tell QA to ignore it.
# Apparently the flash library itself also suffers from this issue
QA_EXECSTACK="opt/flash-libcompat/libcrypto.so.0.9.7
	opt/netscape/plugins32/libflashplayer.so
	opt/netscape/plugins/libflashplayer.so"

pkg_setup() {
	if use x86; then
		export native_install=1
	elif use amd64; then
		# amd64 may unselect the native 64bit install in some circumstances
		if ! use multilib || use 64bit; then
			export native_install=1
		else
			unset native_install
		fi

		if [[ $native_install ]]; then
			# Bug 268336: Some AMD processors fail with native 64-bit flash
			if ! grep -q lahf_lm /proc/cpuinfo; then
				eerror "Your processor does not support the 'lahf' instruction which is used"
				eerror "by Adobe's 64-bit flash binary."

				if use multilib; then
					eerror "Adjust your USE flags to install only the 32-bit version:"
					eerror "  ${CATEGORY}/$PN[+32bit -64bit]"
					die "Incompatible processor for true 64-bit flash, install 32-bit only"
				else
					die "Incompatible processor for true 64-bit flash, multilib profile required for 32-bit version"
				fi
			fi
		fi

		if use multilib && ! use 32bit && ! use 64bit; then
			eerror "You must select at least one library USE flag (32bit or 64bit)"
			die "No library version selected [-32bit -64bit]"
		fi
	fi
}

src_install() {
	if [[ $native_install ]]; then
		# 32b RPM has things hidden in funny places
		use x86 && pushd "${S}/usr/lib/flash-plugin"

		exeinto /opt/netscape/plugins
		doexe libflashplayer.so
		inst_plugin /opt/netscape/plugins/libflashplayer.so

		use x86 && popd

		# 64b tarball has no readme file.
		use x86 && dodoc "${S}/usr/share/doc/flash-plugin-${PV}/readme.txt"
	fi

	if use amd64 && has_multilib_profile && use 32bit; then
		oldabi="${ABI}"
		ABI="x86"

		# 32b plugin
		pushd "${S}/usr/lib/flash-plugin"
			exeinto /opt/netscape/plugins32/
			doexe libflashplayer.so
			inst_plugin /opt/netscape/plugins32/libflashplayer.so
			dodoc "${S}/usr/share/doc/flash-plugin-${PV}/readme.txt"
		popd

		# 32b library compatibility:
		#
		# libcurl and libnss are not currently available in any emul-linux-x86
		# packages, so for amd64 we provide these snarfed out of other binary
		# packages.  libcurl and its ssl dependencies come from
		# app-text/acroread; libnss and its friends come from
		# net-libs/xulrunner-bin
		exeinto /opt/flash-libcompat
		pushd "${WORKDIR}/flash-libcompat-0.2/"
			doexe *
		popd
		echo 'LDPATH="/opt/flash-libcompat"' > 99flash-libcompat
		doenvd 99flash-libcompat

		ABI="${oldabi}"
	fi

	# The magic config file!
	insinto "/etc/adobe"
	doins "${FILESDIR}/mms.cfg"
}

pkg_postinst() {
	if use amd64; then
		if has_version 'www-plugins/nspluginwrapper'; then
			if [[ $native_install ]]; then
				# TODO: Perhaps parse the output of 'nspluginwrapper -l'
				#       However, the 64b flash plugin makes 'nspluginwrapper -l' segfault.
				local FLASH_WRAPPER="${ROOT}/usr/lib64/nsbrowser/plugins/npwrapper.libflashplayer.so"
				if [[ -f ${FLASH_WRAPPER} ]]; then
					einfo "Removing duplicate 32-bit plugin wrapper: Native 64-bit plugin installed"
					nspluginwrapper -r "${FLASH_WRAPPER}"
				fi
			else
				oldabi="${ABI}"
				ABI="x86"
				local FLASH_SOURCE="${ROOT}/usr/$(get_libdir)/${PLUGINS_DIR}/libflashplayer.so"

				einfo "nspluginwrapper detected: Installing plugin wrapper"
				nspluginwrapper -i "${FLASH_SOURCE}"

				ABI="${oldabi}"
			fi
		elif [[ ! $native_install ]]; then
			einfo "To use the 32-bit flash player in a native 64-bit firefox,"
			einfo "you must install www-plugins/nspluginwrapper"
		fi
	fi

	ewarn "Flash player is closed-source, with a long history of security"
	ewarn "issues.  Please consider only running flash applets you know to"
	ewarn "be safe.  The 'flashblock' extension may help for mozilla users:"
	ewarn "  https://addons.mozilla.org/en-US/firefox/addon/433"

	if has_version 'kde-base/konqueror'; then
		elog "Konqueror users - You may need to follow the instructions here:"
		elog "  http://www.gentoo.org/proj/en/desktop/kde/kde-flash.xml"
		elog "For flash to work with your browser."
	fi
}
