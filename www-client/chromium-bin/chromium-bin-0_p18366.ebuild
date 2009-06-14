# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/chromium-bin/chromium-bin-0_p18366.ebuild,v 1.1 2009/06/14 20:49:19 voyageur Exp $

EAPI="2"
inherit eutils multilib

# Latest revision id can be found at
# http://build.chromium.org/buildbot/snapshots/chromium-rel-linux/LATEST
MY_PV="${PV/0\_p}"

DESCRIPTION="Open-source version of Google Chrome web browser"
HOMEPAGE="http://code.google.com/chromium/"
SRC_URI="http://build.chromium.org/buildbot/snapshots/chromium-rel-linux/${MY_PV}/chrome-linux.zip -> ${PN}-${MY_PV}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""

AMD64_DEPEND="amd64? (
	|| ( www-plugins/adobe-flash[32bit]
		www-client/mozilla-firefox-bin
		net-libs/xulrunner-bin )
	>=app-emulation/emul-linux-x86-gtklibs-20081109
	app-emulation/emul-linux-x86-soundlibs
	)"

DEPEND="app-arch/unzip
	${AMD64_DEPEND}"
RDEPEND="media-fonts/corefonts
	>=sys-devel/gcc-4.2
	x86? ( >=dev-libs/nspr-4.7
		>=dev-libs/nss-3.12
		gnome-base/gconf
		x11-libs/pango )
	${AMD64_DEPEND}"

S=${WORKDIR}

QA_EXECSTACK="opt/chromium.org/chrome-linux/chrome"

src_install() {
	declare CHROMIUM_HOME=/opt/chromium.org

	dodir ${CHROMIUM_HOME}
	cp -R chrome-linux/ "${D}"${CHROMIUM_HOME} || die "Unable to install chrome-linux folder"

	# Create symbol links for necessary libraries
	dodir ${CHROMIUM_HOME}/lib
	if use x86; then
		NSS_DIR=../../../usr/$(get_libdir)/nss
		NSPR_DIR=../../../usr/$(get_libdir)/nspr
	elif use amd64; then
		# amd64: we still miss gconf
		if has_version www-client/mozilla-firefox-bin; then
			einfo "Using NSS/NSPR libraries from www-client/mozilla-firefox-bin"
			NSS_DIR=../../../opt/firefox
			NSPR_DIR=../../../opt/firefox
		elif has_version net-libs/xulrunner-bin; then
			einfo "Using NSS/NSPR libraries from net-libs/xulrunner-bin"
			NSS_DIR=../../../opt/xulrunner
			NSPR_DIR=../../../opt/xulrunner
		else
			einfo "Using NSS/NSPR libraries from www-plugins/adobe-flash"
			NSS_DIR=../../../opt/flash-libcompat
			NSPR_DIR=../../../opt/flash-libcompat
		fi

	fi

	dosym ${NSPR_DIR}/libnspr4.so ${CHROMIUM_HOME}/lib/libnspr4.so.0d
	dosym ${NSPR_DIR}/libplc4.so ${CHROMIUM_HOME}/lib/libplc4.so.0d
	dosym ${NSPR_DIR}/libplds4.so ${CHROMIUM_HOME}/lib/libplds4.so.0d
	dosym ${NSS_DIR}/libnss3.so ${CHROMIUM_HOME}/lib/libnss3.so.1d
	dosym ${NSS_DIR}/libnssutil3.so ${CHROMIUM_HOME}/lib/libnssutil3.so.1d
	dosym ${NSS_DIR}/libsmime3.so ${CHROMIUM_HOME}/lib/libsmime3.so.1d
	dosym ${NSS_DIR}/libssl3.so ${CHROMIUM_HOME}/lib/libssl3.so.1d

	# Create chromium-bin wrapper
	make_wrapper chromium-bin ./chrome ${CHROMIUM_HOME}/chrome-linux ${CHROMIUM_HOME}/lib
	newicon "${FILESDIR}"/chromium.png ${PN}.png
	make_desktop_entry chromium-bin "Chromium" ${PN}.png "Network;WebBrowser"
}

pkg_postinst() {
	ewarn "This binary requires the C++ runtime from >=sys-devel/gcc-4.2"
	ewarn "If you get the \"version \`GLIBCXX_3.4.9' not found\" error message,"
	ewarn "switch your active gcc to a version >=4.2 with gcc-config"
}
