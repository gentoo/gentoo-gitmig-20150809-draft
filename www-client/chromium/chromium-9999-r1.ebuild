# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/chromium/chromium-9999-r1.ebuild,v 1.17 2011/04/08 06:23:47 phajdan.jr Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"

inherit eutils fdo-mime flag-o-matic gnome2-utils multilib pax-utils \
	portability python subversion toolchain-funcs versionator virtualx

DESCRIPTION="Open-source version of Google Chrome web browser"
HOMEPAGE="http://chromium.org/"
# subversion eclass fetches gclient, which will then fetch chromium itself
ESVN_REPO_URI="http://src.chromium.org/svn/trunk/tools/depot_tools"
EGCLIENT_REPO_URI="http://src.chromium.org/svn/trunk/src/"

LICENSE="BSD"
SLOT="live"
KEYWORDS=""
IUSE="cups gnome gnome-keyring kerberos xinerama"

RDEPEND="app-arch/bzip2
	dev-libs/dbus-glib
	>=dev-libs/icu-4.4.1
	>=dev-libs/libevent-1.4.13
	dev-libs/libxml2[icu]
	dev-libs/libxslt
	>=dev-libs/nss-3.12.3
	gnome? ( >=gnome-base/gconf-2.24.0 )
	gnome-keyring? ( >=gnome-base/gnome-keyring-2.28.2 )
	>=media-libs/alsa-lib-1.0.19
	media-libs/flac
	virtual/jpeg
	media-libs/libpng
	>=media-libs/libvpx-0.9.5
	media-libs/speex
	cups? ( >=net-print/cups-1.3.11 )
	sys-libs/pam
	sys-libs/zlib
	>=virtual/ffmpeg-0.6.90[threads]
	x11-libs/gtk+:2
	x11-libs/libXScrnSaver
	x11-libs/libXtst"
DEPEND="${RDEPEND}
	dev-lang/perl
	>=dev-util/gperf-3.0.3
	>=dev-util/pkgconfig-0.23
	sys-devel/flex
	>=sys-devel/make-3.81-r2
	x11-libs/libXinerama
	test? ( dev-python/simplejson dev-python/tlslite virtual/krb5 )"
RDEPEND+="
	!=www-client/chromium-9999
	kerberos? ( virtual/krb5 )
	xinerama? ( x11-libs/libXinerama )
	x11-misc/xdg-utils
	virtual/ttf-fonts"

src_unpack() {
	subversion_src_unpack
	mv "${S}" "${WORKDIR}"/depot_tools

	# Most subversion checks and configurations were already run
	EGCLIENT="${WORKDIR}"/depot_tools/gclient
	cd "${ESVN_STORE_DIR}" || die "gclient: can't chdir to ${ESVN_STORE_DIR}"

	if [[ ! -d ${PN} ]]; then
		mkdir -p "${PN}" || die "gclient: can't mkdir ${PN}."
	fi

	cd "${PN}" || die "gclient: can't chdir to ${PN}"

	if [[ ! -f .gclient ]]; then
		einfo "gclient config -->"
		${EGCLIENT} config ${EGCLIENT_REPO_URI} || die "gclient: error creating config"
	fi

	einfo "gclient sync start -->"
	einfo "     repository: ${EGCLIENT_REPO_URI}"
	${EGCLIENT} sync --nohooks || die
	einfo "   working copy: ${ESVN_STORE_DIR}/${PN}"

	mkdir -p "${S}"
	# From export_tarball.py
	CHROMIUM_EXCLUDES="--exclude=src/chrome/test/data
	--exclude=src/chrome/tools/test/reference_build
	--exclude=src/chrome_frame --exclude=src/gears/binaries
	--exclude=src/net/data/cache_tests --exclude=src/o3d/documentation
	--exclude=src/o3d/samples --exclude=src/third_party/lighttpd
	--exclude=src/third_party/WebKit/LayoutTests
	--exclude=src/webkit/data/layout_tests
	--exclude=src/webkit/tools/test/reference_build"
	rsync -rlpgo --exclude=".svn/" ${CHROMIUM_EXCLUDES} src/ "${S}" || die "gclient: can't export to ${S}."

	# Display correct svn revision in about box, and log new version
	CREV=$(subversion__svn_info "src" "Revision")
	echo ${CREV} > "${S}"/build/LASTCHANGE.in || die "setting revision failed"
	. src/chrome/VERSION
	elog "Installing/updating to version ${MAJOR}.${MINOR}.${BUILD}.${PATCH}_p${CREV} "
}

gyp_use() {
	if [[ $# -lt 2 ]]; then
		echo "!!! usage: gyp_use <USEFLAG> <GYPFLAG>" >&2
		return 1
	fi
	if use "$1"; then echo "-D$2=1"; else echo "-D$2=0"; fi
}

egyp() {
	set -- build/gyp_chromium --depth=. "${@}"
	echo "${@}" >&2
	"${@}"
}

pkg_setup() {
	SUFFIX="-${SLOT}"
	CHROMIUM_HOME="/usr/$(get_libdir)/chromium-browser${SUFFIX}"

	# Make sure the build system will use the right tools, bug #340795.
	tc-export AR CC CXX RANLIB

	# Make sure the build system will use the right python, bug #344367.
	python_set_active_version 2
	python_pkg_setup

	# Prevent user problems like bug #299777.
	if ! grep -q /dev/shm <<< $(get_mounts); then
		ewarn "You don't have tmpfs mounted at /dev/shm."
		ewarn "${PN} may fail to start in that configuration."
		ewarn "Please uncomment the /dev/shm entry in /etc/fstab,"
		ewarn "and run 'mount /dev/shm'."
	fi
	if [ `stat -c %a /dev/shm` -ne 1777 ]; then
		ewarn "/dev/shm does not have correct permissions."
		ewarn "${PN} may fail to start in that configuration."
		ewarn "Please run 'chmod 1777 /dev/shm'."
	fi

	# Prevent user problems like bug #348235.
	eshopts_push -s extglob
	if is-flagq '-g?(gdb)?([1-9])'; then
		ewarn "You have enabled debug info (probably have -g or -ggdb in your \$C{,XX}FLAGS)."
		ewarn "You may experience really long compilation times and/or increased memory usage."
		ewarn "If compilation fails, please try removing -g{,gdb} before reporting a bug."
	fi
	eshopts_pop
}

src_prepare() {
	# Make sure we don't use bundled libvpx headers.
	epatch "${FILESDIR}/${PN}-system-vpx-r4.patch"

	# Remove most bundled libraries. Some are still needed.
	find third_party -type f \! -iname '*.gyp*' \
		\! -path 'third_party/WebKit/*' \
		\! -path 'third_party/angle/*' \
		\! -path 'third_party/cacheinvalidation/*' \
		\! -path 'third_party/cld/*' \
		\! -path 'third_party/expat/*' \
		\! -path 'third_party/ffmpeg/*' \
		\! -path 'third_party/flac/flac.h' \
		\! -path 'third_party/gpsd/*' \
		\! -path 'third_party/harfbuzz/*' \
		\! -path 'third_party/hunspell/*' \
		\! -path 'third_party/iccjpeg/*' \
		\! -path 'third_party/launchpad_translations/*' \
		\! -path 'third_party/leveldb/*' \
		\! -path 'third_party/libjingle/*' \
		\! -path 'third_party/libsrtp/*' \
		\! -path 'third_party/libvpx/libvpx.h' \
		\! -path 'third_party/libwebp/*' \
		\! -path 'third_party/mesa/*' \
		\! -path 'third_party/modp_b64/*' \
		\! -path 'third_party/npapi/*' \
		\! -path 'third_party/openmax/*' \
		\! -path 'third_party/ots/*' \
		\! -path 'third_party/protobuf/*' \
		\! -path 'third_party/pyftpdlib/*' \
		\! -path 'third_party/skia/*' \
		\! -path 'third_party/speex/speex.h' \
		\! -path 'third_party/sqlite/*' \
		\! -path 'third_party/tcmalloc/*' \
		\! -path 'third_party/undoview/*' \
		\! -path 'third_party/zlib/contrib/minizip/*' \
		-delete || die

	# Make sure the build system will use the right python, bug #344367.
	# Only convert directories that need it, to save time.
	python_convert_shebangs -q -r 2 build tools
}

src_configure() {
	local myconf=""

	# Never tell the build system to "enable" SSE2, it has a few unexpected
	# additions, bug #336871.
	myconf+=" -Ddisable_sse2=1"

	# Use system-provided libraries.
	# TODO: use_system_hunspell (upstream changes needed).
	# TODO: use_system_ssl (http://crbug.com/58087).
	# TODO: use_system_sqlite (http://crbug.com/22208).
	myconf+="
		-Duse_system_bzip2=1
		-Duse_system_flac=1
		-Duse_system_ffmpeg=1
		-Duse_system_icu=1
		-Duse_system_libevent=1
		-Duse_system_libjpeg=1
		-Duse_system_libpng=1
		-Duse_system_libxml=1
		-Duse_system_speex=1
		-Duse_system_vpx=1
		-Duse_system_xdg_utils=1
		-Duse_system_zlib=1"

	# Optional dependencies.
	myconf+="
		$(gyp_use cups use_cups)
		$(gyp_use gnome use_gconf)
		$(gyp_use gnome-keyring use_gnome_keyring)
		$(gyp_use gnome-keyring linux_link_gnome_keyring)"

	# Enable sandbox.
	myconf+="
		-Dlinux_sandbox_path=${CHROMIUM_HOME}/chrome_sandbox
		-Dlinux_sandbox_chrome_path=${CHROMIUM_HOME}/chrome"

	if host-is-pax; then
		# Prevent the build from failing (bug #301880). The performance
		# difference is very small.
		myconf+=" -Dv8_use_snapshot=0"
	fi

	# Our system ffmpeg should support more codecs than the bundled one
	# for Chromium.
	myconf+=" -Dproprietary_codecs=1"

	# Use target arch detection logic from bug #354601.
	case ${CHOST} in
		i?86-*) myarch=x86 ;;
		x86_64-*)
			if [[ $ABI = "" ]] ; then
				myarch=amd64
			else
				myarch="$ABI"
			fi ;;
		arm*-*) myarch=arm ;;
		*) die "Unrecognized CHOST: ${CHOST}"
	esac

	if [[ $myarch = amd64 ]] ; then
		myconf+=" -Dtarget_arch=x64"
	elif [[ $myarch = x86 ]] ; then
		myconf+=" -Dtarget_arch=ia32"
	elif [[ $myarch = arm ]] ; then
		# TODO: check this again after
		# http://gcc.gnu.org/bugzilla/show_bug.cgi?id=39509 is fixed.
		append-flags -fno-tree-sink

		myconf+=" -Dtarget_arch=arm -Ddisable_nacl=1 -Dlinux_use_tcmalloc=0"
	else
		die "Failed to determine target arch, got '$myarch'."
	fi

	# Make sure that -Werror doesn't get added to CFLAGS by the build system.
	# Depending on GCC version the warnings are different and we don't want
	# the build to fail because of that.
	myconf+=" -Dwerror="

	# Avoid a build error with -Os, bug #352457.
	replace-flags "-Os" "-O2"

	egyp ${myconf} || die
}

src_compile() {
	emake chrome chrome_sandbox BUILDTYPE=Release V=1 || die
	pax-mark m out/Release/chrome
	if use test; then
		emake {base,net}_unittests BUILDTYPE=Release V=1 || die
		pax-mark m out/Release/{base,net}_unittests
	fi
}

src_test() {
	# For more info see bug #350349.
	local mylocale='en_US.utf8'
	if ! locale -a | grep -q "$mylocale"; then
		eerror "${PN} requires ${mylocale} locale for tests"
		eerror "Please read the following guides for more information:"
		eerror "  http://www.gentoo.org/doc/en/guide-localization.xml"
		eerror "  http://www.gentoo.org/doc/en/utf-8.xml"
		die "locale ${mylocale} is not supported"
	fi

	# For more info see bug #350347.
	LC_ALL="${mylocale}" VIRTUALX_COMMAND=out/Release/base_unittests virtualmake \
		'--gtest_filter=-ICUStringConversionsTest.*'

	# DiskCache: we need net/data/cache_tests in the tarball (export_tarball.py)
	# NetUtilTest: bug #361885.
	# HTTPS/SSL: bug #361939.
	# UDP: unstable, active development. We should revisit this later.
	LC_ALL="${mylocale}" VIRTUALX_COMMAND=out/Release/net_unittests virtualmake \
		'--gtest_filter=-*DiskCache*:NetUtilTest.IDNToUnicode*:NetUtilTest.FormatUrl*:*HTTPS*:*SSL*:*UDP*'
}

src_install() {
	exeinto "${CHROMIUM_HOME}"
	doexe out/Release/chrome
	doexe out/Release/chrome_sandbox || die
	fperms 4755 "${CHROMIUM_HOME}/chrome_sandbox"
	newexe "${FILESDIR}"/chromium-launcher-r1.sh chromium-launcher.sh || die
	sed "s:chromium-browser:chromium-browser${SUFFIX}:g" \
		-i "${D}"/"${CHROMIUM_HOME}"/chromium-launcher.sh || die
	sed "s:chromium.desktop:chromium${SUFFIX}.desktop:g" \
		-i "${D}"/"${CHROMIUM_HOME}"/chromium-launcher.sh || die
	sed "s:plugins:plugins --user-data-dir=\${HOME}/.config/chromium${SUFFIX}:" \
		-i "${D}"/"${CHROMIUM_HOME}"/chromium-launcher.sh || die

	# It is important that we name the target "chromium-browser",
	# xdg-utils expect it; bug #355517.
	dosym "${CHROMIUM_HOME}/chromium-launcher.sh" /usr/bin/chromium-browser${SUFFIX} || die
	# keep the old symlink around for consistency
	dosym "${CHROMIUM_HOME}/chromium-launcher.sh" /usr/bin/chromium${SUFFIX} || die

	insinto "${CHROMIUM_HOME}"
	doins out/Release/chrome.pak || die
	doins out/Release/resources.pak || die

	doins -r out/Release/locales || die
	doins -r out/Release/resources || die

	newman out/Release/chrome.1 chromium${SUFFIX}.1 || die
	newman out/Release/chrome.1 chromium-browser${SUFFIX}.1 || die

	# Chromium looks for these in its folder
	# See media_posix.cc and base_paths_linux.cc
	dosym /usr/$(get_libdir)/libavcodec.so.52 "${CHROMIUM_HOME}" || die
	dosym /usr/$(get_libdir)/libavformat.so.52 "${CHROMIUM_HOME}" || die
	dosym /usr/$(get_libdir)/libavutil.so.50 "${CHROMIUM_HOME}" || die

	# Install icons and desktop entry.
	for SIZE in 16 22 24 32 48 64 128 256 ; do
		insinto /usr/share/icons/hicolor/${SIZE}x${SIZE}/apps
		newins chrome/app/theme/chromium/product_logo_${SIZE}.png \
			chromium-browser${SUFFIX}.png || die
	done
	local mime_types="text/html;text/xml;application/xhtml+xml;"
	mime_types+="x-scheme-handler/http;x-scheme-handler/https;" # bug #360797
	make_desktop_entry chromium-browser${SUFFIX} "Chromium ${SLOT}" chromium-browser${SUFFIX} \
		"Network;WebBrowser" "MimeType=${mime_types}"
	sed -e "/^Exec/s/$/ %U/" -i "${D}"/usr/share/applications/*.desktop || die

	# Install GNOME default application entry (bug #303100).
	if use gnome; then
		dodir /usr/share/gnome-control-center/default-apps || die
		insinto /usr/share/gnome-control-center/default-apps
		newins "${FILESDIR}"/chromium-browser.xml chromium-browser${SUFFIX}.xml || die
		sed "s:chromium-browser:chromium-browser${SUFFIX}:g" -i \
			"${D}"/usr/share/gnome-control-center/default-apps/chromium-browser${SUFFIX}.xml
	fi
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update

	# For more info see bug #292201, bug #352263, bug #361859.
	elog
	elog "Depending on your desktop environment, you may need"
	elog "to install additional packages to get icons on the Downloads page."
	elog
	elog "For KDE, the required package is kde-base/oxygen-icons."
	elog
	elog "For other desktop environments, try one of the following:"
	elog " - x11-themes/gnome-icon-theme"
	elog " - x11-themes/tango-icon-theme"

	# For more info see bug #359153.
	elog
	elog "Some web pages may require additional fonts to display properly."
	elog "Try installing some of the following packages if some characters"
	elog "are not displayed properly:"
	elog " - media-fonts/arphicfonts"
	elog " - media-fonts/bitstream-cyberbit"
	elog " - media-fonts/droid"
	elog " - media-fonts/ipamonafont"
	elog " - media-fonts/ja-ipafonts"
	elog " - media-fonts/takao-fonts"
	elog " - media-fonts/wqy-microhei"
	elog " - media-fonts/wqy-zenhei"

	elog
	elog "The live ebuild of chromium is now in its own slot."
	elog "This means that you can have it installed alongside a versioned"
	elog "release and it has its own configuration folder, located at"
	elog "	\${HOME}/.config/chromium-live"
	elog "If you want to use any existing, old configuration, you'll have to"
	elog "rename the old config directory *before* launching chromium-live:"
	elog "	mv \${HOME}/.config/chromium \${HOME}/.config/chromium-live"
	elog "To run, execute chromium-live or chromium-browser-live."
}

pkg_postrm() {
	gnome2_icon_cache_update
}
