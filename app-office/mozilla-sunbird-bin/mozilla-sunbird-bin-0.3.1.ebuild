# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/mozilla-sunbird-bin/mozilla-sunbird-bin-0.3.1.ebuild,v 1.4 2007/03/24 15:01:27 armin76 Exp $

inherit eutils mozilla-launcher multilib mozextension

LANGS="ca cs da de es-ES eu fr ga-IE hu it mn nl pl ru sk sl"

MY_PN="${PN/mozilla-}"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="The Mozilla Sunbird Calendar"
SRC_URI="http://releases.mozilla.org/pub/mozilla.org/calendar/sunbird/releases/${PV}/linux-i686/en-US/sunbird-${PV}.en-US.linux-i686.tar.bz2"
HOMEPAGE="http://www.mozilla.org/projects/calendar/sunbird.html"
RESTRICT="nostrip"

KEYWORDS="-* ~amd64 x86"
SLOT="0"
LICENSE="MPL-1.1 GPL-2 LGPL-2.1"
IUSE=""

# These are in
#
#  http://releases.mozilla.org/pub/mozilla.org/calendar/sunbird/releases/${PV}/langpacks/
#
# for i in $LANGS $SHORTLANGS; do wget $i.xpi -O ${P}-$i.xpi; done
for X in ${LANGS} ; do
	SRC_URI="${SRC_URI}
		linguas_${X/-/_}? ( http://releases.mozilla.org/pub/mozilla.org/calendar/${MY_PN/-bin}/releases/${PV}/langpacks/${MY_PN/-bin}-${PV}.${X}.langpack.xpi )"
	IUSE="${IUSE} linguas_${X/-/_}"
	# english is handled internally
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

S=${WORKDIR}/sunbird

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
				if [[ "${X}" == "${LANG}-"* ]] &&  != *" ${X} "* ]]; then
					has ${X} ${linguas} || linguas="${linguas:+"${linguas} "}${X}"
					continue 2
				fi
			done
		fi
		ewarn "Sorry, but ${PN} does not support the ${LANG} LINGUA"
	done
	elog "Selected language packs (first will be default): $linguas"
}


src_unpack() {
	unpack ${MY_PN/-bin}-${PV}.en-US.linux-i686.tar.bz2

	linguas
	for X in ${linguas}; do
		[[ ${X} != "en" ]] && xpi_unpack "${MY_P/-bin/}.${X}.langpack.xpi"
	done
}

src_install() {
	declare MOZILLA_FIVE_HOME=/opt/sunbird

	# Install sunbird in /opt
	dodir ${MOZILLA_FIVE_HOME%/*}
	mv ${S} ${D}${MOZILLA_FIVE_HOME}

	linguas
	for X in ${linguas}; do
		[[ ${X} != "en" ]] && xpi_install "${WORKDIR}"/"${MY_P/-bin/}.${X}.langpack"
	done

	local LANG=${linguas%% *}
	if [[ -n ${LANG} && ${LANG} != "en" ]]; then
		einfo "Setting default locale to ${LANG}"
		dosed -e "s:general.useragent.locale\", \"en-US\":general.useragent.locale\", \"${LANG}\":" \
			"${MOZILLA_FIVE_HOME}"/defaults/pref/sunbird.js \
			"${MOZILLA_FIVE_HOME}"/defaults/pref/sunbird-l10n.js || \
			die "sed failed to change locale"
	fi

	keepdir ${MOZILLA_FIVE_HOME}/extensions		# required to run!

	# Create /usr/bin/sunbird-bin
	install_mozilla_launcher_stub sunbird-bin ${MOZILLA_FIVE_HOME}

	# Install icon and .desktop for menu entry
	doicon ${FILESDIR}/icon/mozilla-sunbird-bin-icon.png
	domenu ${FILESDIR}/icon/mozilla-sunbird-bin.desktop
}

pkg_preinst() {
	declare MOZILLA_FIVE_HOME=/opt/sunbird

	# Remove entire installed instance to prevent all kinds of
	# problems... see bug 44772 for example
	rm -rf ${ROOT}${MOZILLA_FIVE_HOME}
}

pkg_postinst() {
	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	update_mozilla_launcher_symlinks
}
