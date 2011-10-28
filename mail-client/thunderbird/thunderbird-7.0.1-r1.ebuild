# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/thunderbird/thunderbird-7.0.1-r1.ebuild,v 1.4 2011/10/28 08:44:36 chainsaw Exp $

EAPI="3"
WANT_AUTOCONF="2.1"

inherit flag-o-matic toolchain-funcs mozconfig-3 makeedit multilib mozextension autotools pax-utils python check-reqs

TB_PV="${PV/_beta/b}"
TB_P="${PN}-${TB_PV}"
EMVER="1.3.2"

DESCRIPTION="Thunderbird Mail Client"
HOMEPAGE="http://www.mozilla.com/en-US/thunderbird/"

KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
SLOT="0"
LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
IUSE="bindist gconf +crashreporter +crypt +ipc +lightning mozdom"
PATCH="${PN}-7.0-patches-0.4"
PATCHFF="firefox-7.0-patches-0.5"

FTP_URI="ftp://ftp.mozilla.org/pub/${PN}/releases/"
SRC_URI="${FTP_URI}/${TB_PV}/source/${TB_P}.source.tar.bz2
	crypt? ( http://www.mozilla-enigmail.org/download/source/enigmail-${EMVER}.tar.gz )
	http://dev.gentoo.org/~anarchy/mozilla/patchsets/${PATCH}.tar.xz
	http://dev.gentoo.org/~anarchy/mozilla/patchsets/${PATCHFF}.tar.xz"

if ! [[ ${PV} =~ alpha|beta ]]; then
	# This list can be updated using get_langs.sh from the mozilla overlay
	# Not supported yet bn-BD ro id zh-CN be af el pa-IN bg
	LANGS="ar ca cs da de en en-GB en-US es-AR es-ES et eu fi fr \
	fy-NL ga-IE he hu is it ja ko lt nb-NO nl nn-NO pl pt-BR pt-PT ru si \
	sk sl sq sv-SE tr uk zh-TW"
	NOSHORTLANGS="en-GB es-AR pt-BR zh-TW"

	for X in ${LANGS} ; do
		if [ "${X}" != "en" ] && [ "${X}" != "en-US" ]; then
			SRC_URI="${SRC_URI}
				linguas_${X/-/_}? ( ${FTP_URI}/${TB_PV}/linux-i686/xpi/${X}.xpi -> ${P}-${X}.xpi )"
		fi
		IUSE="${IUSE} linguas_${X/-/_}"
		# english is handled internally
		if [ "${#X}" == 5 ] && ! has ${X} ${NOSHORTLANGS}; then
			if [ "${X}" != "en-US" ]; then
				SRC_URI="${SRC_URI}
					linguas_${X%%-*}? ( ${FTP_URI}/${TB_PV}/linux-i686/xpi/${X}.xpi -> ${P}-${X}.xpi )"
			fi
			IUSE="${IUSE} linguas_${X%%-*}"
		fi
	done
fi

RDEPEND=">=sys-devel/binutils-2.16.1
	>=dev-libs/nss-3.12.10
	>=dev-libs/nspr-4.8.8
	gconf? ( >=gnome-base/gconf-1.2.1:2 )
	media-libs/libpng[apng]
	virtual/libffi
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
	moz_pkgsetup

	if ! use bindist; then
		elog "You are enabling official branding. You may not redistribute this build"
		elog "to any users on your network or the internet. Doing so puts yourself into"
		elog "a legal problem with Mozilla Foundation"
		elog "You can disable it by emerging ${PN} _with_ the bindist USE-flag"
	fi

	# Ensure we have enough disk space to compile
	CHECKREQS_DISK_BUILD="4G"
	check-reqs_pkg_setup
}

src_unpack() {
	unpack ${A}

	if ! [[ ${PV} =~ alpha|beta ]]; then
		linguas
		for X in ${linguas}; do
			# FIXME: Add support for unpacking xpis to portage
			[[ ${X} != "en" ]] && xpi_unpack "${P}-${X}.xpi"
		done
		if [[ ${linguas} != "" && ${linguas} != "en" ]]; then
			einfo "Selected language packs (first will be default): ${linguas}"
		fi
	fi
}

src_prepare() {
	# Apply our Thunderbird patchset
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch "${WORKDIR}/thunderbird"

	# Apply our patchset from firefox to thunderbird as well
	pushd "${S}"/mozilla &>/dev/null || die
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch "${WORKDIR}/firefox"
	popd &>/dev/null || die

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
	mozconfig_annotate '' --enable-system-ffi

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
	declare emid

	emake DESTDIR="${D}" install || die "emake install failed"

	if ! use bindist; then
		newicon "${S}"/other-licenses/branding/thunderbird/content/icon48.png thunderbird-icon.png
		domenu "${FILESDIR}"/icon/${PN}.desktop
	else
		newicon "${S}"/mail/branding/unofficial/content/icon48.png thunderbird-icon-unbranded.png
		newmenu "${FILESDIR}"/icon/${PN}-unbranded.desktop \
			${PN}.desktop

		sed -i -e "s:Mozilla\ Thunderbird:Lanikai:g" \
			"${ED}"/usr/share/applications/${PN}.desktop
	fi

	if use crypt ; then
		cd "${T}" || die
		unzip "${S}"/mozilla/dist/bin/enigmail*.xpi install.rdf || die
		emid=$(sed -n '/<em:id>/!d; s/.*\({.*}\).*/\1/; p; q' install.rdf)

		dodir ${MOZILLA_FIVE_HOME}/extensions/${emid} || die
		cd "${D}"${MOZILLA_FIVE_HOME}/extensions/${emid} || die
		unzip "${S}"/mozilla/dist/bin/enigmail*.xpi || die
	fi

	if use lightning ; then
		emid="{a62ef8ec-5fdc-40c2-873c-223b8a6925cc}"
		dodir ${MOZILLA_FIVE_HOME}/extensions/${emid}
		cd "${ED}"${MOZILLA_FIVE_HOME}/extensions/${emid}
		unzip "${S}"/mozilla/dist/xpi-stage/gdata-provider.xpi

		emid="calendar-timezones@mozilla.org"
		dodir ${MOZILLA_FIVE_HOME}/extensions/${emid}
		cd "${ED}"${MOZILLA_FIVE_HOME}/extensions/${emid}
		unzip "${S}"/mozilla/dist/xpi-stage/calendar-timezones.xpi

		emid="{e2fda1a4-762b-4020-b5ad-a41df1933103}"
		dodir ${MOZILLA_FIVE_HOME}/extensions/${emid}
		cd "${ED}"${MOZILLA_FIVE_HOME}/extensions/${emid}
		unzip "${S}"/mozilla/dist/xpi-stage/lightning.xpi

		# Fix mimetype so it shows up as a calendar application in GNOME 3
		# This requires that the .desktop file was already installed earlier
		sed -e "s:^\(MimeType=\):\1text/calendar;:" \
			-e "s:^\(Categories=\):\1Calendar;:" \
			-i "${ED}"/usr/share/applications/${PN}.desktop
	fi

	if ! [[ ${PV} =~ alpha|beta ]]; then
		linguas
		for X in ${linguas}; do
			[[ ${X} != "en" ]] && xpi_install "${WORKDIR}"/"${P}-${X}"
		done
	fi

	pax-mark m "${ED}"/${MOZILLA_FIVE_HOME}/thunderbird-bin

	# Enable very specific settings for thunderbird-3
	cp "${FILESDIR}"/thunderbird-gentoo-default-prefs-1.js \
		"${ED}/${MOZILLA_FIVE_HOME}/defaults/pref/all-gentoo.js" || \
		die "failed to cp thunderbird-gentoo-default-prefs.js"
}
