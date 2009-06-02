# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/chromium-bin/chromium-bin-9999.ebuild,v 1.4 2009/06/02 08:59:01 voyageur Exp $

EAPI="2"
inherit eutils multilib

DESCRIPTION="Open-source version of Google Chrome web browser"
HOMEPAGE="http://code.google.com/chromium/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""

DEPEND="app-arch/unzip
	net-misc/curl"
RDEPEND=">=dev-libs/nspr-4.7
	>=dev-libs/nss-3.12
	gnome-base/gconf
	media-fonts/corefonts
	>=sys-devel/gcc-4.2
	x11-libs/pango"

S=${WORKDIR}

QA_EXECSTACK="opt/chromium.org/chrome-linux/chrome"

src_unpack() {
	LV=`curl --silent http://build.chromium.org/buildbot/snapshots/chromium-rel-linux/LATEST`
	elog "Installing/updating to version ${LV}"
	wget -c "http://build.chromium.org/buildbot/snapshots/chromium-rel-linux/${LV}/chrome-linux.zip" -O "${DISTDIR}"/${PN}-${LV}.zip
	unpack ${PN}-${LV}.zip
}

src_install() {
	declare CHROMIUM_HOME=/opt/chromium.org

	dodir ${CHROMIUM_HOME}
	cp -R chrome-linux/ "${D}"${CHROMIUM_HOME} || die "Unable to install chrome-linux folder"

	# Create symbol links for necessary libraries
	dodir ${CHROMIUM_HOME}/lib
	if use x86; then
		NSS_DIR=../../../usr/$(get_libdir)/nss
		NSPR_DIR=../../../usr/$(get_libdir)/nspr
	fi
	# amd64: firefox-bin, xulrunner-bin, adobe-flash[32bit] could
	# provide these, but we miss gconf

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
	make_desktop_entrychromium-bin "Chromium" ${PN}.png "Network;WebBrowser"
}
