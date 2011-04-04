# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/thunderbird/thunderbird-3.3_alpha3-r1.ebuild,v 1.1 2011/04/04 02:33:57 anarchy Exp $

EAPI="3"
WANT_AUTOCONF="2.1"

inherit flag-o-matic toolchain-funcs eutils mozconfig-3 makeedit multilib mozextension autotools pax-utils python

# This list can be updated using get_langs.sh from the mozilla overlay
#LANGS="af ar be bg bn-BD ca cs da de el en en-GB en-US es-AR es-ES et eu fi fr \
#fy-NL ga-IE he hu id is it ja ko lt nb-NO nl nn-NO pa-IN pl pt-BR pt-PT ro ru si \
#sk sl sq sv-SE tr uk zh-CN zh-TW"
#NOSHORTLANGS="en-GB es-AR pt-BR zh-TW"

MY_PV="${PV/_alpha/a}"
MY_P="${P/_alpha/a}"
EMVER="1.2a1"

DESCRIPTION="Thunderbird Mail Client"
HOMEPAGE="http://www.mozilla.com/en-US/thunderbird/"

KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
SLOT="0"
LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
IUSE="bindist gconf +crashreporter +crypt +ipc +lightning mozdom"
#PATCH="${PN}-3.1-patches-1.2"

REL_URI="http://releases.mozilla.org/pub/mozilla.org/${PN}/releases"
SRC_URI="${REL_URI}/${MY_PV}/source/${MY_P}.source.tar.bz2
	crypt? ( http://dev.gentoo.org/~anarchy/mozilla/firefox/enigmail-${EMVER}-20110316.tar.bz2 )"
#	http://dev.gentoo.org/~anarchy/mozilla/patchsets/${PATCH}.tar.bz2"

#for X in ${LANGS} ; do
#	if [ "${X}" != "en" ] && [ "${X}" != "en-US" ]; then
#		SRC_URI="${SRC_URI}
#			linguas_${X/-/_}? ( ${REL_URI}/${MY_PV}/linux-i686/xpi/${X}.xpi -> ${P}-${X}.xpi )"
#	fi
#	IUSE="${IUSE} linguas_${X/-/_}"
#	# english is handled internally
#	if [ "${#X}" == 5 ] && ! has ${X} ${NOSHORTLANGS}; then
#		if [ "${X}" != "en-US" ]; then
#			SRC_URI="${SRC_URI}
#				linguas_${X%%-*}? ( ${REL_URI}/${MY_PV}/linux-i686/xpi/${X}.xpi -> ${P}-${X}.xpi )"
#		fi
#		IUSE="${IUSE} linguas_${X%%-*}"
#	fi
#done

RDEPEND=">=sys-devel/binutils-2.16.1
	>=dev-libs/nss-3.12.9
	>=dev-libs/nspr-4.8.7
	gconf? ( >=gnome-base/gconf-1.2.1:2 )
	!x11-plugins/lightning
	!x11-plugins/enigmail
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

S="${WORKDIR}"/comm-central

#linguas() {
#	local LANG SLANG
#	for LANG in ${LINGUAS}; do
#		if has ${LANG} en en_US; then
#			has en ${linguas} || linguas="${linguas:+"${linguas} "}en"
#			continue
#		elif has ${LANG} ${LANGS//-/_}; then
#			has ${LANG//_/-} ${linguas} || linguas="${linguas:+"${linguas} "}${LANG//_/-}"
#			continue
#		elif [[ " ${LANGS} " == *" ${LANG}-"* ]]; then
#			for X in ${LANGS}; do
#				if [[ "${X}" == "${LANG}-"* ]] && \
#					[[ " ${NOSHORTLANGS} " != *" ${X} "* ]]; then
#					has ${X} ${linguas} || linguas="${linguas:+"${linguas} "}${X}"
#					continue 2
#				fi
#			done
#		fi
#		ewarn "Sorry, but ${PN} does not support the ${LANG} LINGUA"
#	done
#}

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

#	linguas
#	for X in ${linguas}; do
#		# FIXME: Add support for unpacking xpis to portage
#		[[ ${X} != "en" ]] && xpi_unpack "${P}-${X}.xpi"
#	done
#	if [[ ${linguas} != "" && ${linguas} != "en" ]]; then
#		einfo "Selected language packs (first will be default): ${linguas}"
#	fi
}

src_prepare() {
	epatch "${FILESDIR}/1001-xulrunner_fix_jemalloc_vs_aslr.patch"
	epatch "${FILESDIR}/2000-thunderbird_gentoo_install_dirs.patch"
	epatch "${FILESDIR}/thunderbird-3.3-gconf-config-update.patch"

	if use crypt ; then
		mv "${WORKDIR}"/enigmail "${S}"/mailnews/extensions/enigmail
		cd "${S}"/mailnews/extensions/enigmail || die
		epatch "${FILESDIR}"/enigmail-1.1.2-20110124-locale-fixup.diff
		cd enigmail
		./makemake -r 2> /dev/null
		sed -i -e 's:@srcdir@:${S}/mailnews/extensions/enigmail:' Makefile.in
		cd "${S}"
	fi

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

#	linguas
#	for X in ${linguas}; do
#		[[ ${X} != "en" ]] && xpi_install "${WORKDIR}"/"${P}-${X}"
#	done

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
