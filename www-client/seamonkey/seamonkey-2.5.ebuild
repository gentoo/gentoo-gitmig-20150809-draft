# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/seamonkey/seamonkey-2.5.ebuild,v 1.1 2011/11/23 08:01:27 polynomial-c Exp $

EAPI="3"
WANT_AUTOCONF="2.1"

inherit flag-o-matic toolchain-funcs eutils mozconfig-3 multilib pax-utils fdo-mime autotools mozextension versionator python

PATCH="${PN}-2.5-patches-01"
EMVER="1.3.3"

MY_PV="${PV/_pre*}"
MY_PV="${MY_PV/_alpha/a}"
MY_PV="${MY_PV/_beta/b}"
MY_PV="${MY_PV/_rc/rc}"
MY_P="${PN}-${MY_PV}"

# release versions usually have language packs. So be careful with changing this.
HAS_LANGS="true"
LANGPACK_PREFIX="${MY_P}."
LANGPACK_SUFFIX=".langpack"
if [[ ${PV} == *_pre* ]] ; then
	# pre-releases. No need for arch teams to change KEYWORDS here.

	REL_URI="ftp://ftp.mozilla.org/pub/mozilla.org/${PN}/nightly/${MY_PV}-candidates/build${PV##*_pre}"
	#LANG_URI="${REL_URI}/langpack"
	LANG_URI="${REL_URI}/linux-i686/xpi"
	LANGPACK_PREFIX=""
	LANGPACK_SUFFIX=""
	#KEYWORDS=""
	KEYWORDS="~alpha ~amd64 ~arm ~ppc ~ppc64 ~x86"
	#HAS_LANGS="false"
else
	# This is where arch teams should change the KEYWORDS.

	#REL_URI="http://releases.mozilla.org/pub/mozilla.org/${PN}/releases/${MY_PV}"
	REL_URI="ftp://ftp.mozilla.org/pub/${PN}/releases/${MY_PV}"
	LANG_URI="${REL_URI}/langpack"
	KEYWORDS="~alpha ~amd64 ~arm ~ppc ~ppc64 ~x86"
	[[ ${PV} == *alpha* ]] && HAS_LANGS="false"
fi

DESCRIPTION="Seamonkey Web Browser"
HOMEPAGE="http://www.seamonkey-project.org"

SLOT="0"
LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
IUSE="+alsa +chatzilla +crypt +ipc +methodjit +roaming system-sqlite +webm"

SRC_URI="${REL_URI}/source/${MY_P}.source.tar.bz2 -> ${P}.source.tar.bz2
	http://dev.gentoo.org/~polynomial-c/mozilla/patchsets/${PATCH}.tar.xz
	crypt? ( http://www.mozilla-enigmail.org/download/source/enigmail-${EMVER}.tar.gz )"

if ${HAS_LANGS} ; then
	LANGS=(be ca cs de en en-GB en-US es-AR es-ES fi fr gl hu it ja lt
	nb-NO nl pl pt-PT ru sk sv-SE tr zh-CN)

	for X in "${LANGS[@]}" ; do
		# en is handled internally
		if [[ ${X} != en ]] ; then
			SRC_URI+="
				linguas_${X/-/_}? ( ${LANG_URI}/${LANGPACK_PREFIX}${X}${LANGPACK_SUFFIX}.xpi -> ${P}-${X}.xpi )"
		fi
		IUSE+=" linguas_${X/-/_}"
		# Install all the specific locale xpis if there's no generic locale xpi
		# Example: there's no pt.xpi, so install all pt-*.xpi
		if ! has ${X%%-*} "${LANGS[@]}"; then
			SRC_URI+="
				linguas_${X%%-*}? ( ${LANG_URI}/${LANGPACK_PREFIX}${X}${LANGPACK_SUFFIX}.xpi -> ${P}-${X}.xpi )"
			IUSE+=" linguas_${X%%-*}"
		fi
	done
fi

ASM_DEPEND=">=dev-lang/yasm-1.1"

# Mesa 7.10 needed for WebGL + bugfixes
RDEPEND=">=sys-devel/binutils-2.16.1
	>=dev-libs/nss-3.12.10
	>=dev-libs/nspr-4.8.8
	>=dev-libs/glib-2.26
	>=media-libs/mesa-7.10
	>=media-libs/libpng-1.4.1[apng]
	>=x11-libs/cairo-1.10
	>=x11-libs/pango-1.14.0
	>=x11-libs/gtk+-2.14
	virtual/libffi
	system-sqlite? ( >=dev-db/sqlite-3.7.5[fts3,secure-delete,unlock-notify,debug=] )
	crypt? ( >=app-crypt/gnupg-1.4 )
	webm? ( media-libs/libvpx
		media-libs/alsa-lib )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	webm? ( amd64? ( ${ASM_DEPEND} )
		x86? ( ${ASM_DEPEND} ) )"

if [[ ${PV} == *beta* ]] ; then
	S="${WORKDIR}/comm-beta"
else
	S="${WORKDIR}/comm-release"
fi

# TODO: Move all the linguas crap to an eclass
linguas() {
	# Generate the list of language packs called "linguas"
	# This list is used to install the xpi language packs
	local LINGUA
	for LINGUA in ${LINGUAS}; do
		if has ${LINGUA} en ; then
			# For mozilla products, en and en_US are handled internally
			continue
		# If this language is supported by ${P},
		elif has ${LINGUA} "${LANGS[@]//-/_}"; then
			# Add the language to linguas, if it isn't already there
			has ${LINGUA//_/-} "${linguas[@]}" || linguas+=(${LINGUA//_/-})
			continue
		# For each short LINGUA that isn't in LANGS,
		# add *all* long LANGS to the linguas list
		elif ! has ${LINGUA%%-*} "${LANGS[@]}"; then
			for LANG in "${LANGS[@]}"; do
				if [[ ${LANG} == ${LINGUA}-* ]]; then
					has ${LANG} "${linguas[@]}" || linguas+=(${LANG})
					continue 2
				fi
			done
		fi
		ewarn "Sorry, but ${P} does not support the ${LINGUA} locale"
	done
}

src_unpack() {
	unpack ${A}

	if ${HAS_LANGS} ; then
		linguas
		for X in "${linguas[@]}"; do
			# FIXME: Add support for unpacking xpis to portage
			xpi_unpack "${P}-${X}.xpi"
		done
	fi
}

pkg_setup() {
	if [[ ${PV} == *_pre* ]] ; then
		ewarn "You're using an unofficial release of ${PN}. Don't file any bug in"
		ewarn "Gentoo's Bugtracker against this package in case it breaks for you."
		ewarn "Those belong to upstream: https://bugzilla.mozilla.org"
	fi

	moz_pkgsetup

	if ! use methodjit ; then
		einfo
		ewarn "You are disabling the method-based JIT in JägerMonkey."
		ewarn "This will greatly slowdown JavaScript in ${PN}!"
	fi
}

src_prepare() {
	# Apply our patches
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch "${WORKDIR}/_seamonkey"

	# browser patches go here
	pushd "${S}"/mozilla &>/dev/null || die
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch "${WORKDIR}/_mozilla"
	popd &>/dev/null || die

	# mailnews patches go here
	pushd "${S}"/mailnews &>/dev/null || die
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch "${WORKDIR}/_mailnews"
	popd &>/dev/null || die

	epatch "${FILESDIR}"/${PN}-2.3.1-scrollbar-mouse-interaction-improvement.patch

	# Allow user to apply any additional patches without modifing ebuild
	epatch_user

	if use crypt ; then
		mv "${WORKDIR}"/enigmail "${S}"/mailnews/extensions/enigmail
		epatch "${FILESDIR}"/enigmail/enigmail-1.3.3-bug373733.patch
		cd "${S}"/mailnews/extensions/enigmail || die
		./makemake -r 2&>/dev/null
		sed -e 's:@srcdir@:${S}/mailnews/extensions/enigmail:' \
			-i Makefile.in || die
		cd "${S}"
	fi

	#Ensure we disable javaxpcom by default to prevent configure breakage
	sed -i -e s:MOZ_JAVAXPCOM\=1::g "${S}"/mozilla/xulrunner/confvars.sh \
		|| die "sed javaxpcom"

	# Disable gnomevfs extension
	sed -i -e "s:gnomevfs::" "${S}/"suite/confvars.sh \
		|| die "Failed to remove gnomevfs extension"

	eautoreconf
}

src_configure() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"
	MEXTENSIONS=""

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	mozconfig_init
	mozconfig_config

	# It doesn't compile on alpha without this LDFLAGS
	use alpha && append-ldflags "-Wl,--no-relax"

	if ! use chatzilla ; then
		MEXTENSIONS+=",-irc"
	fi
	if ! use roaming ; then
		MEXTENSIONS+=",-sroaming"
	fi

	mozconfig_annotate '' --enable-extensions="${MEXTENSIONS}"
	mozconfig_annotate '' --disable-gconf
	mozconfig_annotate '' --enable-jsd
	mozconfig_annotate '' --enable-canvas
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}
	mozconfig_annotate '' --enable-system-ffi

	mozconfig_annotate '' --target="${CTARGET:-${CHOST}}"

	mozconfig_use_enable system-sqlite
	mozconfig_use_enable methodjit

	if use crypt ; then
		mozconfig_annotate "mail crypt" --enable-chrome-format=jar
	fi

	mozconfig_annotate '' --with-system-png

	# Finalize and report settings
	mozconfig_final

	if [[ $(gcc-major-version) -lt 4 ]]; then
		append-cxxflags -fno-stack-protector
	elif [[ $(gcc-major-version) -gt 4 || $(gcc-minor-version) -gt 3 ]]; then
		if use amd64 || use x86; then
			append-flags -mno-avx
		fi
	fi

	####################################
	#
	#  Configure and build
	#
	####################################

	# Work around breakage in makeopts with --no-print-directory
	MAKEOPTS="${MAKEOPTS/--no-print-directory/}"

	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" PYTHON="$(PYTHON)" econf
}

src_compile() {
	emake || die

	# Only build enigmail extension if conditions are met.
	if use crypt ; then
		emake -C "${S}"/mailnews/extensions/enigmail || die "make enigmail failed"
		emake -j1 -C "${S}"/mailnews/extensions/enigmail xpi || die "make enigmail xpi failed"
	fi
}

src_install() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"
	declare emid

	emake DESTDIR="${D}" install || die "emake install failed"
	cp -f "${FILESDIR}"/icon/${PN}.desktop "${T}" || die

	if use crypt ; then
		cd "${T}" || die
		unzip "${S}"/mozilla/dist/bin/enigmail*.xpi install.rdf || die
		emid=$(sed -n '/<em:id>/!d; s/.*\({.*}\).*/\1/; p; q' install.rdf)

		dodir ${MOZILLA_FIVE_HOME}/extensions/${emid} || die
		cd "${D}"${MOZILLA_FIVE_HOME}/extensions/${emid} || die
		unzip "${S}"/mozilla/dist/bin/enigmail*.xpi || die
	fi

	sed 's|^\(MimeType=.*\)$|\1text/x-vcard;text/directory;application/mbox;message/rfc822;x-scheme-handler/mailto;|' \
		-i "${T}"/${PN}.desktop || die
	sed 's|^\(Categories=.*\)$|\1Email;|' -i "${T}"/${PN}.desktop \
		|| die

	if ${HAS_LANGS} ; then
		linguas
		for X in ${linguas}; do
			[[ ${X} != "en" ]] && xpi_install "${WORKDIR}"/"${P}-${X}"
		done
	fi

	# Add StartupNotify=true bug 290401
	if use startup-notification ; then
		echo "StartupNotify=true" >> "${T}"/${PN}.desktop
	fi

	# Install icon and .desktop for menu entry
	newicon "${S}"/suite/branding/nightly/content/icon64.png ${PN}.png \
		|| die
	domenu "${T}"/${PN}.desktop || die

	# Add our default prefs
	sed "s|SEAMONKEY_PVR|${PVR}|" "${FILESDIR}"/all-gentoo.js \
		> "${D}"${MOZILLA_FIVE_HOME}/defaults/pref/all-gentoo.js \
			|| die

	# Plugins dir
	rm -rf "${D}"${MOZILLA_FIVE_HOME}/plugins || die "failed to remove existing plugins dir"
	dosym ../nsbrowser/plugins "${MOZILLA_FIVE_HOME}"/plugins || die
	#share_plugins_dir

	doman "${S}"/suite/app/${PN}.1 || die
}

pkg_preinst() {
	declare MOZILLA_FIVE_HOME="${ROOT}/usr/$(get_libdir)/${PN}"

	if [ -d ${MOZILLA_FIVE_HOME}/plugins ] ; then
		rm ${MOZILLA_FIVE_HOME}/plugins -rf
	fi
}

pkg_postinst() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	# Update mimedb for the new .desktop file
	fdo-mime_desktop_database_update

	if use chatzilla ; then
		elog "chatzilla is now an extension which can be en-/disabled and configured via"
		elog "the Add-on manager."
	fi
}
