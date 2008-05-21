# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/mozilla-sunbird-bin/mozilla-sunbird-bin-0.8.ebuild,v 1.3 2008/05/21 11:24:16 armin76 Exp $

inherit eutils mozilla-launcher multilib mozextension

LANGS="ca cs da de en-US es-AR es-ES eu fr ga-IE hu it ja ka ko lt mk mn nb-NO nl pa-IN pl pt-BR pt-PT ru sk sl sv-SE tr uk zh-CN"
NOSHORTLANGS="es-AR pt-BR zh-TW"

MY_PN="${PN/mozilla-}"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Mozilla Sunbird Calendar"
SRC_URI="http://releases.mozilla.org/pub/mozilla.org/calendar/sunbird/releases/${PV}/linux-i686/en-US/sunbird-${PV}.en-US.linux-i686.tar.gz"
HOMEPAGE="http://www.mozilla.org/projects/calendar/sunbird.html"
RESTRICT="strip"
QA_EXECSTACK="opt/sunbird/extensions/talkback@mozilla.org/components/libqfaservices.so"
QA_TEXTRELS="opt/sunbird/extensions/talkback@mozilla.org/components/libqfaservices.so"

KEYWORDS="-* ~amd64 x86"
SLOT="0"
LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
IUSE=""

# These are in
#
#  http://releases.mozilla.org/pub/mozilla.org/calendar/sunbird/releases/${PV}/langpacks/
#
# for i in $LANGS $SHORTLANGS; do wget $i.xpi -O ${P}-$i.xpi; done
for X in ${LANGS} ; do
	if [ "${X}" != "en" ] && [ "${X}" != "en-US" ]; then
		SRC_URI="${SRC_URI}
			linguas_${X/-/_}? ( http://dev.gentooexperimental.org/~armin76/dist/${P/-bin}-xpi/${P/-bin/}-${X}.xpi )"
	fi
	IUSE="${IUSE} linguas_${X/-/_}"
	# english is handled internally
	if [ "${#X}" == 5 ] && ! has ${X} ${NOSHORTLANGS}; then
		if [ "${X}" != "en-US" ]; then
			SRC_URI="${SRC_URI}
				linguas_${X%%-*}? ( http://dev.gentooexperimental.org/~armin76/dist/${P/-bin}-xpi/${P/-bin/}-${X}.xpi )"
		fi
		IUSE="${IUSE} linguas_${X%%-*}"
	fi
done

DEPEND="app-arch/unzip"
RDEPEND="x11-libs/libXrender
	x11-libs/libXt
	x11-libs/libXmu
	x86? (
		>=x11-libs/gtk+-2.2
		=virtual/libstdc++-3.3
	)
	amd64? (
		>=app-emulation/emul-linux-x86-baselibs-1.0
		>=app-emulation/emul-linux-x86-gtklibs-1.0
		app-emulation/emul-linux-x86-compat
	)
	>=www-client/mozilla-launcher-1.56"

S="${WORKDIR}/sunbird"

pkg_config() {
	# This is a binary x86 package => ABI=x86
	# Please keep this in future versions
	# Danny van Dyk <kugelfang@gentoo.org> 2005/03/26
	has_multilib_profile && ABI="x86"
}

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

src_unpack() {
	unpack ${MY_PN/-bin}-${PV}.en-US.linux-i686.tar.gz

	linguas
	for X in ${linguas}; do
		[[ ${X} != "en" ]] && xpi_unpack "${P/-bin/}-${X}.xpi"
	done
	if [[ ${linguas} != "" && ${linguas} != "en" ]]; then
		einfo "Selected language packs (first will be default): ${linguas}"
	fi
}

src_install() {
	declare MOZILLA_FIVE_HOME="/opt/sunbird"

	# Install sunbird in /opt
	dodir ${MOZILLA_FIVE_HOME%/*}
	touch "${S}"/extensions/talkback@mozilla.org/chrome.manifest
	touch "${S}"/extensions/{972ce4c6-7e08-4474-a285-3208198ce6fd}/chrome.manifest
	touch "${S}"/extensions/{e2fda1a4-762b-4020-b5ad-a41df1933103}/chrome.manifest
	mv "${S}" "${D}"${MOZILLA_FIVE_HOME}

	linguas
	for X in ${linguas}; do
		[[ ${X} != "en" ]] && xpi_install "${WORKDIR}"/"${P/-bin/}-${X}"
	done

	local LANG=${linguas%% *}
	if [[ -n ${LANG} && ${LANG} != "en" ]]; then
		einfo "Setting default locale to ${LANG}"
		dosed -e "s:general.useragent.locale\", \"en-US\":general.useragent.locale\", \"${LANG}\":" \
			${MOZILLA_FIVE_HOME}/defaults/pref/sunbird.js \
			${MOZILLA_FIVE_HOME}/defaults/pref/sunbird-l10n.js || \
			die "sed failed to change locale"
	fi

	# Create /usr/bin/sunbird-bin
	install_mozilla_launcher_stub sunbird-bin ${MOZILLA_FIVE_HOME}

	# Install icon and .desktop for menu entry
	doicon "${FILESDIR}"/icon/${PN}-icon.png
	domenu "${FILESDIR}"/icon/${PN}.desktop
}

pkg_preinst() {
	declare MOZILLA_FIVE_HOME="/opt/sunbird"

	# Remove entire installed instance to prevent all kinds of
	# problems... see bug 44772 for example
	rm -rf "${ROOT}"${MOZILLA_FIVE_HOME}
}

pkg_postinst() {
	use amd64 && einfo "NB: You just installed a 32-bit sunbird"
	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	update_mozilla_launcher_symlinks
}
