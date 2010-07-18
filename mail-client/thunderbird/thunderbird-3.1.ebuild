# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/thunderbird/thunderbird-3.1.ebuild,v 1.6 2010/07/18 23:55:10 anarchy Exp $

EAPI="3"
WANT_AUTOCONF="2.1"

inherit flag-o-matic toolchain-funcs eutils mozconfig-3 makeedit multilib mozextension autotools

# This list can be updated using get_langs.sh from the mozilla overlay
LANGS="af ar be bg bn-BD ca cs da de el en en-GB en-US es-AR es-ES et eu fi fr \
fy-NL ga-IE he hu id is it ja ko lt nb-NO nl nn-NO pa-IN pl pt-BR pt-PT ro ru si \
sk sl sq sv-SE tr uk zh-CN zh-TW"
NOSHORTLANGS="en-GB es-AR pt-BR zh-TW"

MY_PV="${PV/_rc/rc}"
MY_P="${P/_rc/rc}"

DESCRIPTION="Thunderbird Mail Client"
HOMEPAGE="http://www.mozilla.com/en-US/thunderbird/"

KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
SLOT="0"
LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
IUSE="alsa ldap crypt bindist libnotify lightning mozdom system-sqlite wifi"
PATCH="mozilla-${PN}-3.1-patches-0.1"

REL_URI="http://releases.mozilla.org/pub/mozilla.org/${PN}/releases"
SRC_URI="${REL_URI}/${MY_PV}/source/${MY_P}.source.tar.bz2
	http://dev.gentoo.org/~anarchy/dist/${PATCH}.tar.bz2"

for X in ${LANGS} ; do
	if [ "${X}" != "en" ] && [ "${X}" != "en-US" ]; then
		SRC_URI="${SRC_URI}
			linguas_${X/-/_}? ( ${REL_URI}/${MY_PV}/linux-i686/xpi/${X}.xpi -> ${P}-${X}.xpi )"
	fi
	IUSE="${IUSE} linguas_${X/-/_}"
	# english is handled internally
	if [ "${#X}" == 5 ] && ! has ${X} ${NOSHORTLANGS}; then
		if [ "${X}" != "en-US" ]; then
			SRC_URI="${SRC_URI}
				linguas_${X%%-*}? ( ${REL_URI}/${MY_PV}/linux-i686/xpi/${X}.xpi -> ${P}-${X}.xpi )"
		fi
		IUSE="${IUSE} linguas_${X%%-*}"
	fi
done

RDEPEND=">=sys-devel/binutils-2.16.1
	>=dev-libs/nss-3.12.3
	>=dev-libs/nspr-4.8
	>=app-text/hunspell-1.2
	x11-libs/cairo[X]
	x11-libs/pango[X]

	alsa? ( media-libs/alsa-lib )
	libnotify? ( >=x11-libs/libnotify-0.4 )
	system-sqlite? ( >=dev-db/sqlite-3.6.22-r2[fts3,secure-delete] )
	wifi? ( net-wireless/wireless-tools )

	!x11-plugins/lightning"

PDEPEND="crypt? ( >=x11-plugins/enigmail-1.1 )"

S="${WORKDIR}"/comm-1.9.2

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
	export BUILD_OFFICIAL=1
	export MOZILLA_OFFICIAL=1

	if ! use bindist; then
		elog "You are enabling official branding. You may not redistribute this build"
		elog "to any users on your network or the internet. Doing so puts yourself into"
		elog "a legal problem with Mozilla Foundation"
		elog "You can disable it by emerging ${PN} _with_ the bindist USE-flag"
	fi
}

src_unpack() {
	unpack ${A}

	linguas
	for X in ${linguas}; do
		# FIXME: Add support for unpacking xpis to portage
		[[ ${X} != "en" ]] && xpi_unpack "${P}-${X}.xpi"
	done
	if [[ ${linguas} != "" && ${linguas} != "en" ]]; then
		einfo "Selected language packs (first will be default): ${linguas}"
	fi
}

src_prepare() {
	# Apply our patches
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch "${WORKDIR}"

	# Fix broken media support
	epatch "${FILESDIR}/${PN}-3.1-noalsa-fixup.patch"

	epatch "${FILESDIR}"/${PN}-3.1-gcc45.patch

	# ARM fixes, bug 327783
	epatch "${FILESDIR}/${PN}-xul-1.9.2-arm-fixes.patch"

	eautoreconf

	cd mozilla
	eautoreconf
	cd js/src
	eautoreconf
}

src_configure() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/mozilla-${PN}"
	MEXTENSIONS="default"

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	touch mail/config/mozconfig
	mozconfig_init
	mozconfig_config

	# It doesn't compile on alpha without this LDFLAGS
	use alpha && append-ldflags "-Wl,--no-relax"

	mozconfig_annotate '' --enable-extensions="${MEXTENSIONS}"
	mozconfig_annotate '' --enable-application=mail
	mozconfig_annotate '' --with-default-mozilla-five-home="${EPREFIX}${MOZILLA_FIVE_HOME}"
	mozconfig_annotate '' --with-user-appdir=.thunderbird
	mozconfig_annotate '' --with-system-nspr --with-nspr-prefix="${EPREFIX}"/usr
	mozconfig_annotate '' --with-system-nss --with-nss-prefix="${EPREFIX}"/usr
	mozconfig_annotate '' --with-sqlite-prefix="${EPREFIX}"/usr
	mozconfig_annotate '' --x-includes="${EPREFIX}"/usr/include --x-libraries="${EPREFIX}"/usr/$(get_libdir)
	mozconfig_annotate 'broken' --disable-crashreporter
	mozconfig_annotate '' --with-system-hunspell

	# Use enable features
	mozconfig_use_enable ldap
	mozconfig_use_enable ldap ldap-experimental
	mozconfig_use_enable libnotify
	mozconfig_use_enable lightning calendar
	mozconfig_use_enable wifi necko-wifi
	mozconfig_use_enable system-sqlite
	mozconfig_use_enable !bindist official-branding
	mozconfig_use_enable alsa ogg
	mozconfig_use_enable alsa wave

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
	fi

	CPPFLAGS="${CPPFLAGS}" \
	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" \
	econf || die
}

src_compile() {
	# Should the build use multiprocessing? Not enabled by default, as it tends to break
	[ "${WANT_MP}" = "true" ] && jobs=${MAKEOPTS} || jobs="-j1"
	emake ${jobs} || die
}

src_install() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/mozilla-${PN}"

	emake DESTDIR="${D}" install || die "emake install failed"

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

	linguas
	for X in ${linguas}; do
		[[ ${X} != "en" ]] && xpi_install "${WORKDIR}"/"${P}-${X}"
	done

	if ! use bindist; then
		newicon "${S}"/other-licenses/branding/thunderbird/content/icon48.png thunderbird-icon.png
		domenu "${FILESDIR}"/icon/${PN}.desktop
	else
		newicon "${S}"/mail/branding/unofficial/content/icon48.png thunderbird-icon-unbranded.png
		newmenu "${FILESDIR}"/icon/${PN}-unbranded.desktop \
			${PN}.desktop
	fi

	# Warn user that remerging enigmail is neccessary on USE=crypt
	use crypt && ewarn "Please remerge x11-plugins/enigmail after updating ${PN}."

	# Enable very specific settings for thunderbird-3
	cp "${FILESDIR}"/thunderbird-gentoo-default-prefs-1.js \
		"${ED}/${MOZILLA_FIVE_HOME}/defaults/pref/all-gentoo.js" || \
		die "failed to cp thunderbird-gentoo-default-prefs.js"
}
