# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mozilla-thunderbird-bin/mozilla-thunderbird-bin-3.0.ebuild,v 1.1 2009/12/20 19:21:16 anarchy Exp $
EAPI="2"

inherit eutils multilib mozextension

LANGS="af ar be ca cs de el en-US es-AR es-ES et eu fi fr fy-NL ga-IE hu id is it ja ko lt nb-NO nl nn-NO pa-IN pl pt-BR ro ru si sk sv-SE uk"
NOSHORTLANGS="es-AR"

MY_PV="${PV/_beta/b}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Thunderbird Mail Client"
REL_URI="http://releases.mozilla.org/pub/mozilla.org/thunderbird/releases/"
SRC_URI="${REL_URI}/${MY_PV}/linux-i686/en-US/thunderbird-${MY_PV}.tar.bz2"
HOMEPAGE="http://www.mozilla.com/thunderbird"
RESTRICT="strip"

KEYWORDS="-* ~amd64 ~x86"
SLOT="0"
LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
IUSE=""

for X in ${LANGS} ; do
	if [ "${X}" != "en" ] && [ "${X}" != "en-US" ]; then
		SRC_URI="${SRC_URI}
			linguas_${X/-/_}? ( ${REL_URI}/${MY_PV}/linux-i686/xpi/${X}.xpi -> ${P/-bin/}-${X}.xpi )"
	fi
	IUSE="${IUSE} linguas_${X/-/_}"
	# english is handled internally
	if [ "${#X}" == 5 ] && ! has ${X} ${NOSHORTLANGS}; then
		if [ "${X}" != "en-US" ]; then
			SRC_URI="${SRC_URI}
				linguas_${X%%-*}? ( ${REL_URI}/${MY_PV}/linux-i686/xpi/${X}.xpi -> ${P/-bin/}-${X}.xpi )"
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
	)
	amd64? (
		>=app-emulation/emul-linux-x86-baselibs-1.0
		>=app-emulation/emul-linux-x86-gtklibs-1.0
		app-emulation/emul-linux-x86-compat
	)"

S="${WORKDIR}/thunderbird"

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
		ewarn "Sorry, but ${PN} does not support the ${LANG} LINGUA"
	done
}

src_unpack() {
	unpack ${A}

	linguas
	for X in ${linguas}; do
		[[ ${X} != en ]] && xpi_unpack "${P/-bin}-${X}.xpi"
	done
}

src_install() {
	declare MOZILLA_FIVE_HOME="/opt/thunderbird"

	# Install thunderbird in /opt
	dodir ${MOZILLA_FIVE_HOME%/*}
	mv "${S}" "${D}"${MOZILLA_FIVE_HOME}

	linguas
	for X in ${linguas}; do
		[[ ${X} != en ]] && xpi_install ${WORKDIR}/${P/-bin}-${X}
	done

	# Create symbolic link /usr/bin/thunderbird-bin
	dodir /usr/bin
	dosym "${MOZILLA_FIVE_HOME}/thunderbird" /usr/bin/thunderbird-bin

	# Install icon and .desktop for menu entry
	doicon "${FILESDIR}"/icon/${PN}-icon.png
	domenu "${FILESDIR}"/icon/${PN}.desktop

	# revdep-rebuild entry
	insinto /etc/revdep-rebuild
	doins "${FILESDIR}"/10thunderbird-bin

	# install ldpath env.d
	doenvd "${FILESDIR}"/71thunderbird-bin

	# Enable very specific settings for thunderbird-3
	cp "${FILESDIR}"/thunderbird-gentoo-default-prefs.js \
		"${D}/${MOZILLA_FIVE_HOME}/defaults/pref/all-gentoo.js" || \
		die "failed to cp thunderbird-gentoo-default-prefs.js"
}

pkg_postinst() {
	#elog "For enigmail, please see instructions at"
	#elog "  http://enigmail.mozdev.org/"

	if use x86; then
		if ! has_version 'gnome-base/gconf' || ! has_version 'gnome-base/orbit' \
			|| ! has_version 'net-misc/curl'; then
			einfo
			einfo "For using the crashreporter, you need gnome-base/gconf,"
			einfo "gnome-base/orbit and net-misc/curl emerged."
			einfo
		fi
		if has_version 'net-misc/curl' && built_with_use --missing \
			true 'net-misc/curl' nss; then
			einfo
			einfo "Crashreporter won't be able to send reports"
			einfo "if you have curl emerged with the nss USE-flag"
			einfo
		fi
	else
		einfo
		einfo "NB: You just installed a 32-bit thunderbird"
		einfo
		einfo "Crashreporter won't work on amd64"
		einfo
	fi

	einfo
	elog "We have moved away from mozilla-launcher, as it has major design flaws."
	elog "You will need to update your symlinks to use thunderbird-bin as the executable"
	elog "to launch thunderbird-bin. If you are used to just typing thunderbird to start, you"
	elog "can create an alias in your ${HOME}/.bashrc. Example: alias thunderbird="thunderbird-bin""
}
