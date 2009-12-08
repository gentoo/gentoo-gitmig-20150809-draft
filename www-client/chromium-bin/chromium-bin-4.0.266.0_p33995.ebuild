# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/chromium-bin/chromium-bin-4.0.266.0_p33995.ebuild,v 1.1 2009/12/08 10:33:57 voyageur Exp $

EAPI="2"
inherit eutils multilib

# Latest revision id can be found at
# http://build.chromium.org/buildbot/snapshots/chromium-rel-linux/LATEST
MY_PV="${PV/[0-9.]*\_p}"

DESCRIPTION="Open-source version of Google Chrome web browser (binary version)"
HOMEPAGE="http://code.google.com/chromium/"
SRC_URI="x86? ( http://build.chromium.org/buildbot/snapshots/chromium-rel-linux/${MY_PV}/chrome-linux.zip -> ${PN}-x86-${MY_PV}.zip )
	amd64? ( http://build.chromium.org/buildbot/snapshots/chromium-rel-linux-64/${MY_PV}/chrome-linux.zip -> ${PN}-amd64-${MY_PV}.zip )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="gnome-base/gconf
	media-fonts/corefonts
	>=media-libs/alsa-lib-1.0.19
	>=sys-devel/gcc-4.2
	>=dev-libs/nspr-4.7
	>=dev-libs/nss-3.12.3
	x11-libs/pango
	x11-themes/gnome-icon-theme"

S=${WORKDIR}

QA_EXECSTACK="opt/chromium.org/chrome-linux/chrome"

# Ogg/Theora/Vorbis-only FFmpeg binaries
QA_TEXTRELS="opt/chromium.org/chrome-linux/libffmpegsumo.so"
QA_PRESTRIPPED="opt/chromium.org/chrome-linux/libffmpegsumo.so"

pkg_setup() {
	# Built with SSE2 enabled, so will fail on older processors
	if [[ ${ROOT} == "/" ]] && ! grep -q sse2 /proc/cpuinfo; then
		die "This binary requires SSE2 support, it will not work on older processors"
	fi
}

src_install() {
	declare CHROMIUM_HOME=/opt/chromium.org

	dodir ${CHROMIUM_HOME}
	cp -R chrome-linux/ "${D}"${CHROMIUM_HOME} || die "Unable to install chrome-linux folder"

	# Man page (rename to prevent collision with chromium)
	newman chrome-linux/chrome.1 chromium-bin.1
	rm "${D}"${CHROMIUM_HOME}/chrome-linux/chrome.1

	# Plugins symlink
	dosym /usr/$(get_libdir)/nsbrowser/plugins ${CHROMIUM_HOME}/chrome-linux/plugins

	# Create symlinks for needed libraries
	dodir ${CHROMIUM_HOME}/nss-nspr
	NSS_DIR=/usr/$(get_libdir)/nss
	NSPR_DIR=/usr/$(get_libdir)/nspr

	dosym ${NSPR_DIR}/libnspr4.so ${CHROMIUM_HOME}/nss-nspr/libnspr4.so.0d
	dosym ${NSPR_DIR}/libplc4.so ${CHROMIUM_HOME}/nss-nspr/libplc4.so.0d
	dosym ${NSPR_DIR}/libplds4.so ${CHROMIUM_HOME}/nss-nspr/libplds4.so.0d
	dosym ${NSS_DIR}/libnss3.so ${CHROMIUM_HOME}/nss-nspr/libnss3.so.1d
	dosym ${NSS_DIR}/libnssutil3.so ${CHROMIUM_HOME}/nss-nspr/libnssutil3.so.1d
	dosym ${NSS_DIR}/libsmime3.so ${CHROMIUM_HOME}/nss-nspr/libsmime3.so.1d
	dosym ${NSS_DIR}/libssl3.so ${CHROMIUM_HOME}/nss-nspr/libssl3.so.1d

	# Create chromium-bin wrapper
	make_wrapper chromium-bin ./chrome ${CHROMIUM_HOME}/chrome-linux ${CHROMIUM_HOME}/nss-nspr:${CHROMIUM_HOME}/chrome-linux
	newicon "${FILESDIR}"/chromium.png ${PN}.png
	make_desktop_entry chromium-bin "Chromium (bin)" ${PN} "Network;WebBrowser"
	sed -e "/^Exec/s/$/ %U/" -i "${D}"/usr/share/applications/*.desktop \
		|| die "desktop file sed failed"
}

pkg_postinst() {
	ewarn "This binary requires the C++ runtime from >=sys-devel/gcc-4.2"
	ewarn "If you get the \"version \`GLIBCXX_3.4.9' not found\" error message,"
	ewarn "switch your active gcc to a version >=4.2 with gcc-config"
	if [[ ${ROOT} != "/" ]]; then
		ewarn "This package will not work on processors without SSE2 instruction"
		ewarn "set support (Intel Pentium III/AMD Athlon or older)."
	fi
}
