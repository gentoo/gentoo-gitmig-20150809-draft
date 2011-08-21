# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/thunderbird/thunderbird-6.0.ebuild,v 1.2 2011/08/21 18:31:32 nirbheek Exp $

EAPI="3"
WANT_AUTOCONF="2.1"

inherit flag-o-matic toolchain-funcs eutils mozconfig-3 makeedit multilib mozextension autotools pax-utils python

TB_PV="${PV/_beta/b}"
TB_P="${PN}-${TB_PV}"
EMVER="1.3"

DESCRIPTION="Thunderbird Mail Client"
HOMEPAGE="http://www.mozilla.com/en-US/thunderbird/"

KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
SLOT="0"
LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
IUSE="bindist gconf +crashreporter +crypt +ipc +lightning mozdom"
PATCH="${PN}-5.0-patches-0.1"

FTP_URI="ftp://ftp.mozilla.org/pub/${PN}/releases/"
SRC_URI="${FTP_URI}/${TB_PV}/source/${TB_P}.source.tar.bz2
	crypt? ( http://www.mozilla-enigmail.org/download/source/enigmail-${EMVER}.tar.gz )
	http://dev.gentoo.org/~anarchy/mozilla/patchsets/${PATCH}.tar.bz2"

if ! [[ ${PV} =~ alpha|beta ]]; then
	# This list can be updated using get_langs.sh from the mozilla overlay
	# Not supported yet bn-BD ro id zh-CN be af el pa-IN bg
	LANGS=(ar be bn-BD br ca cs da de el en en-GB en-US es-AR es-ES et eu fi fr
	fy-NL ga-IE gd gl he hu id is it ja ko lt nb-NO nl nn-NO pl pt-BR pt-PT rm
	ru si sk sl sq sv-SE ta-LK tr uk)

	for X in "${LANGS[@]}" ; do
		# en and en_US are handled internally
		if [[ ${X} != en ]] && [[ ${X} != en-US ]]; then
			SRC_URI="${SRC_URI}
				linguas_${X/-/_}? ( ${FTP_URI}/${TB_PV}/linux-i686/xpi/${X}.xpi -> ${P}-${X}.xpi )"
		fi
		IUSE="${IUSE} linguas_${X/-/_}"
		# Install all the specific locale xpis if there's no generic locale xpi
		# Example: there's no pt.xpi, so install all pt-*.xpi
		if ! has ${X%%-*} "${LANGS[@]}"; then
			SRC_URI="${SRC_URI}
				linguas_${X%%-*}? ( ${FTP_URI}/${TB_PV}/linux-i686/xpi/${X}.xpi -> ${P}-${X}.xpi )"
			IUSE="${IUSE} linguas_${X%%-*}"
		fi
	done
fi

RDEPEND=">=sys-devel/binutils-2.16.1
	>=dev-libs/nss-3.12.10
	>=dev-libs/nspr-4.8.8
	gconf? ( >=gnome-base/gconf-1.2.1:2 )
	media-libs/libpng[apng]
	!x11-plugins/lightning
	!x11-plugins/enigmail
	system-sqlite? ( >=dev-db/sqlite-3.7.5[fts3,secure-delete,unlock-notify,debug=] )
	crypt?  ( || (
		( >=app-crypt/gnupg-2.0
			|| (
				app-crypt/pinentry[gtk]
				app-crypt/pinentry[qt4]
			)
		)
		=app-crypt/gnupg-1.4*
	) )"

DEPEND="${RDEPEND}"

S="${WORKDIR}"/comm-release

# TODO: Move all the linguas crap to an eclass
linguas() {
	# Generate the list of language packs called "linguas"
	# This list is used to install the xpi language packs
	local LINGUA
	for LINGUA in ${LINGUAS}; do
		if has ${LINGUA} en en_US; then
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


pkg_setup() {
	moz_pkgsetup

	if ! use bindist; then
		elog "You are enabling official branding. You may not redistribute this build"
		elog "to any users on your network or the internet. Doing so puts yourself into"
		elog "a legal problem with Mozilla Foundation"
		elog "You can disable it by emerging ${PN} _with_ the bindist USE-flag"
	fi
}

src_unpack() {
	unpack ${A}

	if ! [[ ${PV} =~ alpha|beta ]]; then
		linguas
		for X in "${linguas[@]}"; do
			# FIXME: Add support for unpacking xpis to portage
			xpi_unpack "${P}-${X}.xpi"
		done
		if [[ "${linguas[*]}" != "" ]]; then
			einfo "Selected language packs (first will be default): ${linguas[*]}"
		fi
	fi
}

src_prepare() {
	# Apply our patches
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch "${WORKDIR}"

	epatch "${FILESDIR}"/fix-thunderbird-calender-support.patch

	if use crypt ; then
		mv "${WORKDIR}"/enigmail "${S}"/mailnews/extensions/enigmail
		cd "${S}"/mailnews/extensions/enigmail || die
		./makemake -r 2&> /dev/null
		sed -i -e 's:@srcdir@:${S}/mailnews/extensions/enigmail:' Makefile.in
		cd "${S}"
	fi

	#Fix compilation with curl-7.21.7 bug 376027
	sed -e '/#include <curl\/types.h>/d'  \
		-i "${S}"/mozilla/toolkit/crashreporter/google-breakpad/src/common/linux/http_upload.cc \
		-i "${S}"/mozilla/toolkit/crashreporter/google-breakpad/src/common/linux/libcurl_wrapper.cc \
		-i "${S}"/mozilla/config/system-headers \
		-i "${S}"/mozilla/js/src/config/system-headers || die "Sed failed"

	# Allow user to apply any additional patches without modifing ebuild
	epatch_user

	eautoreconf

	cd mozilla
	eautoreconf
	cd js/src
	eautoreconf
}

src_configure() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"
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

	if use crypt ; then
		# omni.jar breaks enigmail
		mozconfig_annotate '' --enable-chrome-format=jar
	fi
	mozconfig_annotate '' --enable-extensions="${MEXTENSIONS}"
	mozconfig_annotate '' --with-default-mozilla-five-home="${EPREFIX}${MOZILLA_FIVE_HOME}"
	mozconfig_annotate '' --with-user-appdir=.thunderbird
	mozconfig_annotate '' --with-system-png

	# Use enable features
	mozconfig_use_enable lightning calendar
	mozconfig_use_enable gconf

	# Bug #72667
	if use mozdom; then
		MEXTENSIONS="${MEXTENSIONS},inspector"
	fi

	# Finalize and report settings
	mozconfig_final

	####################################
	#
	#  Configure and build
	#
	####################################

	# Disable no-print-directory
	MAKEOPTS=${MAKEOPTS/--no-print-directory/}

	if [[ $(gcc-major-version) -lt 4 ]]; then
		append-cxxflags -fno-stack-protector
	elif [[ $(gcc-major-version) -gt 4 || $(gcc-minor-version) -gt 3 ]]; then
		if use amd64 || use x86; then
			append-flags -mno-avx
		fi
	fi

	CPPFLAGS="${CPPFLAGS}" \
	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" \
	econf || die
}

src_compile() {
	emake || die

	# Only build enigmail extension if crypt enabled.
	if use crypt ; then
		emake -C "${S}"/mailnews/extensions/enigmail || die "make enigmail failed"
		emake -C "${S}"/mailnews/extensions/enigmail xpi || die "make enigmail xpi failed"
	fi
}

src_install() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	emake DESTDIR="${D}" install || die "emake install failed"

	if use crypt ; then
		cd "${T}" || die
		unzip "${S}"/mozilla/dist/bin/enigmail*.xpi install.rdf || die
		emid=$(sed -n '/<em:id>/!d; s/.*\({.*}\).*/\1/; p; q' install.rdf)

		dodir ${MOZILLA_FIVE_HOME}/extensions/${emid} || die
		cd "${D}"${MOZILLA_FIVE_HOME}/extensions/${emid} || die
		unzip "${S}"/mozilla/dist/bin/enigmail*.xpi || die
	fi

	if use lightning ; then
		declare emid emd1 emid2

		emid="{a62ef8ec-5fdc-40c2-873c-223b8a6925cc}"
		dodir ${MOZILLA_FIVE_HOME}/extensions/${emid}
		cd "${ED}"${MOZILLA_FIVE_HOME}/extensions/${emid}
		unzip "${S}"/mozilla/dist/xpi-stage/gdata-provider.xpi

		emid1="calendar-timezones@mozilla.org"
		dodir ${MOZILLA_FIVE_HOME}/extensions/${emid1}
		cd "${ED}"${MOZILLA_FIVE_HOME}/extensions/${emid1}
		unzip "${S}"/mozilla/dist/xpi-stage/calendar-timezones.xpi

		emid2="{e2fda1a4-762b-4020-b5ad-a41df1933103}"
		dodir ${MOZILLA_FIVE_HOME}/extensions/${emid2}
		cd "${ED}"${MOZILLA_FIVE_HOME}/extensions/${emid2}
		unzip "${S}"/mozilla/dist/xpi-stage/lightning.xpi
	fi

	if ! [[ ${PV} =~ alpha|beta ]]; then
		linguas
		for X in "${linguas[@]}"; do
			xpi_install "${WORKDIR}/${P}-${X}"
		done
	fi

	if ! use bindist; then
		newicon "${S}"/other-licenses/branding/thunderbird/content/icon48.png thunderbird-icon.png
		domenu "${FILESDIR}"/icon/${PN}.desktop
	else
		newicon "${S}"/mail/branding/unofficial/content/icon48.png thunderbird-icon-unbranded.png
		newmenu "${FILESDIR}"/icon/${PN}-unbranded.desktop \
			${PN}.desktop

		sed -i -e "s:Mozilla\ Thunderbird:Lanikai:g" \
			"${D}"/usr/share/applications/${PN}.desktop

	fi

	pax-mark m "${ED}"/${MOZILLA_FIVE_HOME}/thunderbird-bin

	# Enable very specific settings for thunderbird-3
	cp "${FILESDIR}"/thunderbird-gentoo-default-prefs-1.js \
		"${ED}/${MOZILLA_FIVE_HOME}/defaults/pref/all-gentoo.js" || \
		die "failed to cp thunderbird-gentoo-default-prefs.js"
}
