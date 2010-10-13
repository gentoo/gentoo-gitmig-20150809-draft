# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/icecat/icecat-3.6.9.ebuild,v 1.9 2010/10/13 00:11:37 anarchy Exp $
EAPI="2"
WANT_AUTOCONF="2.1"

inherit flag-o-matic toolchain-funcs eutils mozconfig-3 makeedit multilib pax-utils fdo-mime autotools mozextension java-pkg-opt-2

LANGS="af ar as be bg bn-BD bn-IN ca cs cy da de el en en-GB en-US eo es-AR
es-CL es-ES es-MX et eu fa fi fr fy-NL ga-IE gl gu-IN he hi-IN hr hu id is it ja
ka kk kn ko ku lt lv mk ml mr nb-NO nl nn-NO oc or pa-IN pl pt-BR pt-PT rm ro
ru si sk sl sq sr sv-SE ta te th tr uk vi zh-CN zh-TW"
# Malformed install.rdf: ta-LK

NOSHORTLANGS="en-GB es-AR es-CL es-MX pt-BR zh-CN zh-TW"

MAJ_XUL_PV="1.9.2"
MAJ_PV="${PV/_*/}" # Without the _rc and _beta stuff
DESKTOP_PV="3.6"
MY_PV="${PV/_rc/rc}" # Handle beta for SRC_URI
XUL_PV="${MAJ_XUL_PV}${MAJ_PV/${DESKTOP_PV}/}" # Major + Minor version no.s
FIREFOX_PN="firefox"
FIREFOX_P="${FIREFOX_PN}-${PV}"
PATCH="${FIREFOX_PN}-3.6-patches-0.2"

DESCRIPTION="GNU project's edition of Mozilla Firefox"
HOMEPAGE="http://www.gnu.org/software/gnuzilla/"

KEYWORDS="amd64 ppc ppc64 x86"
SLOT="0"
LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
IUSE="+alsa +ipc java libnotify system-sqlite wifi"

SRC_URI="mirror://gnu/gnuzilla/${MY_PV}/${PN}-${MY_PV}.tar.bz2
	http://dev.gentoo.org/~anarchy/mozilla/patchsets/${PATCH}.tar.bz2"
LANGPACK_URI="http://gnuzilla.gnu.org/download/langpacks/"

for X in ${LANGS} ; do
	if [ "${X}" != "en" ] && [ "${X}" != "en-US" ]; then
		SRC_URI="${SRC_URI}
			linguas_${X/-/_}? ( ${LANGPACK_URI}/${MY_PV}/${X}.xpi -> ${P}-${X}.xpi )"
	fi
	IUSE="${IUSE} linguas_${X/-/_}"
	# english is handled internally
	if [ "${#X}" == 5 ] && ! has ${X} ${NOSHORTLANGS}; then
		if [ "${X}" != "en-US" ]; then
			SRC_URI="${SRC_URI}
				linguas_${X%%-*}? ( ${LANGPACK_URI}/${MY_PV}/${X}.xpi -> ${P}-${X}.xpi )"
		fi
		IUSE="${IUSE} linguas_${X%%-*}"
	fi
done

RDEPEND="
	>=sys-devel/binutils-2.16.1
	>=dev-libs/nss-3.12.7
	>=dev-libs/nspr-4.8.6
	>=app-text/hunspell-1.2
	system-sqlite? ( >=dev-db/sqlite-3.6.22-r2[fts3,secure-delete] )
	alsa? ( media-libs/alsa-lib )
	>=x11-libs/cairo-1.8.8[X]
	x11-libs/pango[X]
	wifi? ( net-wireless/wireless-tools )
	libnotify? ( >=x11-libs/libnotify-0.4 )
	~net-libs/xulrunner-${XUL_PV}[ipc=,java=,wifi=,libnotify=,system-sqlite=]"

DEPEND="${RDEPEND}
	java? ( >=virtual/jdk-1.4 )
	dev-util/pkgconfig"

RDEPEND="${RDEPEND} java? ( >=virtual/jre-1.4 )"

# This is a copy of the launcher program installed as part of xulrunner, so has
# already been stripped. Bug #332071 for details.
QA_PRESTRIPPED="usr/$(get_libdir)/${PN}/${PN}"

linguas() {
	local LANG SLANG
	for LANG in ${LINGUAS}; do
		if has ${LANG} en en_US; then
			has en ${linguas} || linguas="${linguas:+"${linguas} "}en"
			continue
		elif has ${LANG} ${LANGS//-/_}; then
			has ${LANG//_/-} ${linguas} || linguas="${linguas:+"${linguas} "}${LANG//_/-}"
			continue
		elif [[ " ${LANGS} " == *" ${LANG}-"* ]]; then
			for X in ${LANGS}; do
				if [[ "${X}" == "${LANG}-"* ]] && \
					[[ " ${NOSHORTLANGS} " != *" ${X} "* ]]; then
					has ${X} ${linguas} || linguas="${linguas:+"${linguas} "}${X}"
					continue 2
				fi
			done
		fi
		ewarn "Sorry, but ${PN} does not support the ${LANG} LINGUA"
	done
}

pkg_setup() {
	# Ensure we always build with C locale.
	export LANG="C"
	export LC_ALL="C"
	export LC_MESSAGES="C"
	export LC_CTYPE="C"

	java-pkg-opt-2_pkg_setup
}

src_unpack() {
	#xz -dc -- "${DISTDIR}/icecat-${MY_PV}.tar.xz" | tar xof - || die "failed to unpack"
	unpack ${A} #${PATCH}.tar.bz2

	linguas
	for X in ${linguas}; do
		# FIXME: Add support for unpacking xpis to portage
		[[ ${X} != "en" ]] && xpi_unpack "${P}-${X}.xpi"
	done
}

src_prepare() {
	# Integrate rebranding
	sed -i "s|/firefox|/icecat|" \
		"${WORKDIR}"/001-firefox_gentoo_install_dirs.patch

	# Fix preferences location
	sed -i 's|defaults/pref/|defaults/preferences/|' browser/installer/packages-static || die "sed failed"

	# Apply our patches
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch "${WORKDIR}"

	# Fix rebranding
	sed -i 's|\$(DIST)/bin/firefox|\$(DIST)/bin/icecat|' browser/app/Makefile.in

	eautoreconf

	cd js/src
	eautoreconf
}

src_configure() {
	# We will build our own .mozconfig
	rm "${S}"/.mozconfig

	MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"
	MEXTENSIONS="default"

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	mozconfig_init
	mozconfig_config

	# It doesn't compile on alpha without this LDFLAGS
	use alpha && append-ldflags "-Wl,--no-relax"

	# Specific settings for icecat
	echo "export MOZ_PHOENIX=1" >> "${S}"/.mozconfig
	echo "mk_add_options MOZ_PHOENIX=1" "${S}"/.mozconfig
	mozconfig_annotate '' --with-branding=browser/branding/unofficial
	mozconfig_annotate '' --disable-official-branding
	mozconfig_annotate '' --with-user-appdir=.icecat

	mozconfig_annotate '' --enable-extensions="${MEXTENSIONS}"
	mozconfig_annotate '' --enable-application=browser
	mozconfig_annotate '' --disable-mailnews
	mozconfig_annotate 'broken' --disable-crashreporter
	mozconfig_annotate '' --enable-image-encoder=all
	mozconfig_annotate '' --enable-canvas
	mozconfig_annotate 'gtk' --enable-default-toolkit=cairo-gtk2
	# Bug 60668: Galeon doesn't build without oji enabled, so enable it
	# regardless of java setting.
	mozconfig_annotate '' --enable-oji --enable-mathml
	mozconfig_annotate 'places' --enable-storage --enable-places
	mozconfig_annotate '' --enable-safe-browsing

	# Build mozdevelop permately
	mozconfig_annotate ''  --enable-jsd --enable-xpctools

	# System-wide install specs
	mozconfig_annotate '' --disable-installer
	mozconfig_annotate '' --disable-updater
	mozconfig_annotate '' --disable-strip
	mozconfig_annotate '' --disable-install-strip

	# Use system libraries
	mozconfig_annotate '' --enable-system-cairo
	mozconfig_annotate '' --enable-system-hunspell
	mozconfig_annotate '' --with-system-nspr
	mozconfig_annotate '' --with-system-nss
	mozconfig_annotate '' --with-system-bz2
	mozconfig_annotate '' --with-system-libxul
	mozconfig_annotate '' --with-libxul-sdk=/usr/$(get_libdir)/xulrunner-devel-${MAJ_XUL_PV}

	mozconfig_use_enable ipc # +ipc, upstream default
	mozconfig_use_enable libnotify
	mozconfig_use_enable java javaxpcom
	mozconfig_use_enable wifi necko-wifi
	mozconfig_use_enable alsa ogg
	mozconfig_use_enable alsa wave
	mozconfig_use_enable system-sqlite

	# Other browser-specific settings
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}

	# Finalize and report settings
	mozconfig_final

	if [[ $(gcc-major-version) -lt 4 ]]; then
		append-cxxflags -fno-stack-protector
	fi

	####################################
	#
	#  Configure and build
	#
	####################################

	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" econf
}

src_compile() {
	# Should the build use multiprocessing? Not enabled by default, as it tends to break
	[ "${WANT_MP}" = "true" ] && jobs=${MAKEOPTS} || jobs="-j1"
	emake ${jobs} || die
}

src_install() {
	MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	emake DESTDIR="${D}" install || die "emake install failed"

	linguas
	for X in ${linguas}; do
		[[ ${X} != "en" ]] && xpi_install "${WORKDIR}"/"${P}-${X}"
	done

	# Install icon and .desktop for menu entry
	newicon "${S}"/browser/branding/unofficial/default48.png icecat-icon.png
	newmenu "${FILESDIR}"/icon/icecat.desktop ${PN}-${DESKTOP_PV}.desktop

	# Add StartupNotify=true bug 237317
	if use startup-notification ; then
		echo "StartupNotify=true" >> "${D}"/usr/share/applications/${PN}-${DESKTOP_PV}.desktop
	fi

	pax-mark m "${D}"/${MOZILLA_FIVE_HOME}/${PN}

	# Enable very specific settings not inherited from xulrunner
	cp "${FILESDIR}"/firefox-default-prefs.js \
		"${D}/${MOZILLA_FIVE_HOME}/defaults/preferences/all-gentoo.js" || \
		die "failed to cp icecat-default-prefs.js"
	# Plugins dir
	dosym ../nsbrowser/plugins "${MOZILLA_FIVE_HOME}"/plugins \
		|| die "failed to symlink"
}

pkg_postinst() {
	ewarn "All the packages built against ${PN} won't compile,"
	ewarn "any package that fails to build warrants a bug report."
	elog

	# Update mimedb for the new .desktop file
	fdo-mime_desktop_database_update
}
