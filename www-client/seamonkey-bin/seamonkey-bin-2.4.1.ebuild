# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/seamonkey-bin/seamonkey-bin-2.4.1.ebuild,v 1.1 2011/11/16 08:51:20 polynomial-c Exp $

EAPI="4"

inherit eutils mozilla-launcher multilib mozextension pax-utils

LANGS=(be ca cs de en-GB en-US es-AR es-ES fi fr gl hu it
ja lt nb-NO nl pl pt-PT ru sk sv-SE tr zh-CN)

MY_PV="${PV/_alpha/a}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Mozilla Application Suite - web browser, email, HTML editor, IRC"
HTTP_URI="http://releases.mozilla.org/pub/mozilla.org/seamonkey/releases/${MY_PV}/"
SRC_URI="${HTTP_URI}/linux-i686/en-US/seamonkey-${MY_PV}.tar.bz2"
HOMEPAGE="http://www.seamonkey-project.org/"
RESTRICT="strip"
QA_EXECSTACK="opt/seamonkey/*"

KEYWORDS="-* ~amd64 ~x86"
SLOT="0"
LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
IUSE="startup-notification"

DEPEND="app-arch/unzip"
RDEPEND="dev-libs/dbus-glib
	x11-libs/libXrender
	x11-libs/libXt
	x11-libs/libXmu
	x86? (
		>=x11-libs/gtk+-2.2:2
		>=media-libs/alsa-lib-1.0.16
	)
	amd64? (
		>=app-emulation/emul-linux-x86-baselibs-20081109
		>=app-emulation/emul-linux-x86-gtklibs-20081109
		>=app-emulation/emul-linux-x86-soundlibs-20081109
	)
	!<www-client/seamonkey-bin-2"

S="${WORKDIR}/seamonkey"

for X in "${LANGS[@]}" ; do
	# en and en_US are handled internally
	if [[ ${X} != en ]] && [[ ${X} != en-US ]]; then
		SRC_URI="${SRC_URI}
			linguas_${X/-/_}? (
			${HTTP_URI}/langpack/seamonkey-${MY_PV}.${X}.langpack.xpi -> ${P/-bin/}-${X}.xpi )"
	fi
	IUSE="${IUSE} linguas_${X/-/_}"
	# Install all the specific locale xpis if there's no generic locale xpi
	# Example: there's no pt.xpi, so install all pt-*.xpi
	if ! has ${X%%-*} "${LANGS[@]}"; then
		SRC_URI="${SRC_URI}
			linguas_${X%%-*}? (
			${HTTP_URI}/langpack/seamonkey-${MY_PV}.${X}.langpack.xpi -> ${P/-bin/}-${X}.xpi )"
	IUSE="${IUSE} linguas_${X%%-*}"
	fi
done

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
	# This is a binary x86 package => ABI=x86
	# Please keep this in future versions
	# Danny van Dyk <kugelfang@gentoo.org> 2005/03/26
	has_multilib_profile && ABI="x86"
}

src_unpack() {
	unpack ${A}

	linguas
	for X in "${linguas[@]}"; do
		# FIXME: Add support for unpacking xpis to portage
		[[ ${X} != "en" ]] && xpi_unpack "${P/-bin/}-${X}.xpi"
	done
	if [[ "${linguas[*]}" != "" && "${linguas[*]}" != "en" ]]; then
		einfo "Selected language packs (first will be default): ${linguas[*]}"
	fi
}

src_install() {
	declare MOZILLA_FIVE_HOME=/opt/seamonkey

	# Install seamonkey in /opt
	dodir ${MOZILLA_FIVE_HOME%/*}
	mv "${S}" "${D}${MOZILLA_FIVE_HOME}"

	linguas
	for X in "${linguas[@]}"; do
		[[ ${X} != "en" ]] && xpi_install "${WORKDIR}"/"${P/-bin/}-${X}"
	done

	local LANG=${linguas%% *}
	if [[ -n ${LANG} && ${LANG} != "en" ]]; then
		elog "Setting default locale to ${LANG}"
		echo "pref(\"general.useragent.locale\", \"${LANG}\");" \
			>> "${D}${MOZILLA_FIVE_HOME}"/defaults/pref/${PN}-prefs.js || \
			die "sed failed to change locale"
	fi

	# Create /usr/bin/seamonkey-bin
	dodir /usr/bin/
	cat <<EOF >"${D}"/usr/bin/seamonkey-bin
#!/bin/sh
unset LD_PRELOAD
exec /opt/seamonkey/seamonkey "\$@"
EOF
	fperms 0755 /usr/bin/seamonkey-bin

	# Install icon and .desktop for menu entry
	doicon "${FILESDIR}/icon/${PN}.png"
	domenu "${FILESDIR}/icon/${PN}.desktop"

	if use startup-notification; then
	    echo "StartupNotify=true" >> "${D}"/usr/share/applications/${PN}.desktop
	fi

	# revdep-rebuild entry
	insinto /etc/revdep-rebuild
	doins "${FILESDIR}"/10${PN} || die

	ln -sfn "/usr/$(get_libdir)/nsbrowser/plugins" \
	            "${D}${MOZILLA_FIVE_HOME}/plugins" || die

	# Required in order to use plugins and even run seamonkey on hardened.
	pax-mark m "${ED}"/${MOZILLA_FIVE_HOME}/{seamonkey,seamonkey-bin,plugin-container}
}

pkg_postinst() {
	use amd64 && einfo "NB: You just installed a 32-bit seamonkey"
}
