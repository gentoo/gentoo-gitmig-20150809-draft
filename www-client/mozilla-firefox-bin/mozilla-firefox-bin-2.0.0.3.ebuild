# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/mozilla-firefox-bin/mozilla-firefox-bin-2.0.0.3.ebuild,v 1.1 2007/04/02 09:02:45 armin76 Exp $

inherit eutils mozilla-launcher multilib mozextension

LANGS="af ar be bg ca cs da de el en-GB es-AR es-ES eu fi fr fy-NL ga-IE gu-IN he hu it ja ka ko ku lt mk mn nb-NO nl nn-NO pa-IN pl pt-BR pt-PT ru sk sl sv-SE tr zh-CN zh-TW"
NOSHORTLANGS="en-GB es-AR pt-BR zh-TW"

DESCRIPTION="Firefox Web Browser"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${PV}/linux-i686/en-US/firefox-${PV}.tar.gz"
HOMEPAGE="http://www.mozilla.org/projects/firefox"
RESTRICT="nostrip"

KEYWORDS="-* ~amd64 ~x86"
SLOT="0"
LICENSE="MPL-1.1 GPL-2 LGPL-2.1"
IUSE=""

for X in ${LANGS} ; do
	SRC_URI="${SRC_URI}
		linguas_${X/-/_}? ( http://gentooexperimental.org/~genstef/dist/${P/-bin}-xpi/${P/-bin/}-${X}.xpi )"
	IUSE="${IUSE} linguas_${X/-/_}"
	# english is handled internally
	if [ "${#X}" == 5 ] && ! has ${X} ${NOSHORTLANGS}; then
		SRC_URI="${SRC_URI}
			linguas_${X%%-*}? ( http://gentooexperimental.org/~genstef/dist/${P/-bin}-xpi/${P/-bin/}-${X}.xpi )"
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
	>=www-client/mozilla-launcher-1.41"

S=${WORKDIR}/firefox

pkg_setup() {
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
		ewarn "Sorry, but mozilla-firefox does not support the ${LANG} LINGUA"
	done
	einfo "Selected language packs (first will be default): $linguas"
}

src_unpack() {
	unpack firefox-${PV}.tar.gz

	linguas
	for X in ${linguas}; do
		[[ ${X} != "en" ]] && xpi_unpack "${P/-bin/}-${X}.xpi"
	done
}

src_install() {
	declare MOZILLA_FIVE_HOME=/opt/firefox

	# Install firefox in /opt
	dodir ${MOZILLA_FIVE_HOME%/*}
	touch ${S}/extensions/talkback@mozilla.org/chrome.manifest
	mv ${S} ${D}${MOZILLA_FIVE_HOME}

	linguas
	for X in ${linguas}; do
		[[ ${X} != "en" ]] && xpi_install "${WORKDIR}"/"${P/-bin/}-${X}"
	done

	local LANG=${linguas%% *}
	if [[ -n ${LANG} && ${LANG} != "en" ]]; then
		einfo "Setting default locale to ${LANG}"
		dosed -e "s:general.useragent.locale\", \"en-US\":general.useragent.locale\", \"${LANG}\":" \
			"${MOZILLA_FIVE_HOME}"/defaults/pref/firefox.js \
			"${MOZILLA_FIVE_HOME}"/defaults/pref/firefox-l10n.js || \
			die "sed failed to change locale"
	fi

	# Create /usr/bin/firefox-bin
	install_mozilla_launcher_stub firefox-bin ${MOZILLA_FIVE_HOME}

	# Install icon and .desktop for menu entry
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/icon/${PN}-icon.png
	insinto /usr/share/applications
	doins ${FILESDIR}/icon/${PN}.desktop

	# revdep-rebuild entry
	insinto /etc/revdep-rebuild
	doins ${FILESDIR}/10firefox-bin

	# install ldpath env.d
	insinto /etc/env.d
	doins ${FILESDIR}/71firefox-bin
}

pkg_preinst() {
	declare MOZILLA_FIVE_HOME=/opt/firefox

	# Remove entire installed instance to prevent all kinds of
	# problems... see bug 44772 for example
	rm -rf ${ROOT}${MOZILLA_FIVE_HOME}
}

pkg_postinst() {
	if use amd64; then
		echo
		einfo "NB: You just installed a 32-bit firefox"
	fi

	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	update_mozilla_launcher_symlinks
}
