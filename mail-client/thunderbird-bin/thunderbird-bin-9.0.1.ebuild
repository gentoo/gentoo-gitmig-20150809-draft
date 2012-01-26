# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/thunderbird-bin/thunderbird-bin-9.0.1.ebuild,v 1.4 2012/01/26 15:01:17 nirbheek Exp $

EAPI="3"

inherit eutils multilib mozextension pax-utils fdo-mime gnome2-utils nsplugins

# Can be updated using scripts/get_langs.sh from mozilla overlay
LANGS=(ar be bg bn-BD br ca cs da de el en en-GB en-US es-AR es-ES et eu fi fr
fy-NL ga-IE gd gl he hu id is it ja ko lt nb-NO nl nn-NO pa-IN pl pt-BR pt-PT rm
ro ru si sk sl sq sv-SE ta-LK tr uk vi zh-CN zh-TW)

MY_PN="${PN/-bin}"
MY_PV="${PV/_beta/b}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Thunderbird Mail Client"
FTP_URI="ftp://ftp.mozilla.org/pub/mozilla.org/${MY_PN}/releases/"
SRC_URI="
	amd64? ( ${FTP_URI}/${MY_PV}/linux-x86_64/en-US/${MY_P}.tar.bz2 -> ${PN}_x86_64-${PV}.tar.bz2 )
	x86? ( ${FTP_URI}/${MY_PV}/linux-i686/en-US/${MY_P}.tar.bz2 -> ${PN}_i686-${PV}.tar.bz2 )"
HOMEPAGE="http://www.mozilla.com/thunderbird"
RESTRICT="strip"

KEYWORDS="-* amd64 x86"
SLOT="0"
LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
IUSE="+crashreporter"

for X in "${LANGS[@]}" ; do
	# en and en_US are handled internally
	if [[ ${X} != en ]] && [[ ${X} != en-US ]]; then
		SRC_URI="${SRC_URI}
			linguas_${X/-/_}? ( ${FTP_URI}/${MY_PV}/linux-i686/xpi/${X}.xpi -> ${P/-bin}-${X}.xpi )"
	fi
	IUSE="${IUSE} linguas_${X/-/_}"
	# Install all the specific locale xpis if there's no generic locale xpi
	# Example: there's no pt.xpi, so install all pt-*.xpi
	if ! has ${X%%-*} "${LANGS[@]}"; then
		SRC_URI="${SRC_URI}
			linguas_${X%%-*}? ( ${FTP_URI}/${MY_PV}/linux-i686/xpi/${X}.xpi -> ${P/-bin}-${X}.xpi )"
		IUSE="${IUSE} linguas_${X%%-*}"
	fi
done

DEPEND="app-arch/unzip"
RDEPEND="x11-libs/libXrender
	x11-libs/libXt
	x11-libs/libXmu
	>=x11-libs/gtk+-2.2:2
	crashreporter? ( net-misc/curl ) "

S="${WORKDIR}/${MY_PN}"

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

src_unpack() {
	unpack ${A}

	linguas
	for X in "${linguas[@]}"; do
		xpi_unpack "${P/-bin}-${X}.xpi"
	done
}

src_install() {
	declare MOZILLA_FIVE_HOME="/opt/${MY_PN}"

	# Install thunderbird in /opt
	dodir ${MOZILLA_FIVE_HOME%/*}
	mv "${S}" "${D}"${MOZILLA_FIVE_HOME}

	linguas
	for X in "${linguas[@]}"; do
		xpi_install "${WORKDIR}/${P/-bin}-${X}"
	done

	# Create /usr/bin/thunderbird-bin
	dodir /usr/bin/
	cat <<EOF >"${D}"/usr/bin/${PN}
#!/bin/sh
unset LD_PRELOAD
LD_LIBRARY_PATH="${MOZILLA_FIVE_HOME}"
exec ${MOZILLA_FIVE_HOME}/thunderbird "\$@"
EOF
	fperms 0755 /usr/bin/${PN}

	# Install icon and .desktop for menu entry
	doicon "${FILESDIR}"/icon/${PN}-icon.png
	domenu "${FILESDIR}"/icon/${PN}.desktop

	# revdep-rebuild entry
	insinto /etc/revdep-rebuild
	doins "${FILESDIR}"/10${PN}

	# Enable very specific settings for thunderbird-3
	cp "${FILESDIR}"/thunderbird-gentoo-default-prefs.js \
		"${D}/${MOZILLA_FIVE_HOME}/defaults/pref/all-gentoo.js" || \
		die "failed to cp thunderbird-gentoo-default-prefs.js"

	# Plugins dir
	share_plugins_dir

	pax-mark m "${ED}"/${MOZILLA_FIVE_HOME}/{thunderbird-bin,thunderbird,plugin-container}
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
