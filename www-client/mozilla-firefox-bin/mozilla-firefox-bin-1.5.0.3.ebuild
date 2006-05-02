# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/mozilla-firefox-bin/mozilla-firefox-bin-1.5.0.3.ebuild,v 1.1 2006/05/02 23:06:14 anarchy Exp $

inherit eutils mozilla-launcher multilib mozextension

LANGS="ar ca cs da de el en-GB es-AR es-ES fi fr ga-IE he hu it ja ko mk nb-NO nl pl pt-BR ro ru sk sl sv-SE tr zh-CN zh-TW"
SHORTLANGS="es-ES ga-IE nb-NO sv-SE"

DESCRIPTION="Firefox Web Browser"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${PV}/linux-i686/en-US/firefox-${PV}.tar.gz"
HOMEPAGE="http://www.mozilla.org/projects/firefox"
RESTRICT="nostrip"

for X in ${LANGS} ; do
	SRC_URI="${SRC_URI} linguas_${X/-/_}? ( mirror://gentoo/firefox-${X}-${PV}.xpi )"
done

for X in ${SHORTLANGS} ; do
	SRC_URI="${SRC_URI} linguas_${X%%-*}? ( mirror://gentoo/firefox-${X}-${PV}.xpi )"
done

KEYWORDS="-* ~amd64 ~x86"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="|| ( (	x11-libs/libXrender
		x11-libs/libXt
		x11-libs/libXmu
		)
		virtual/x11
	)
	x86? (
		>=sys-libs/lib-compat-1.0-r2
		>=x11-libs/gtk+-2.2
	)
	amd64? (
		>=app-emulation/emul-linux-x86-baselibs-1.0
		>=app-emulation/emul-linux-x86-gtklibs-1.0
	)
	>=www-client/mozilla-launcher-1.41
	=virtual/libstdc++-3.3
	virtual/libc"

S=${WORKDIR}/firefox

pkg_setup() {
	# This is a binary x86 package => ABI=x86
	# Please keep this in future versions
	# Danny van Dyk <kugelfang@gentoo.org> 2005/03/26
	has_multilib_profile && ABI="x86"
}

linguas() {
	linguas=
	local LANG
	for LANG in ${LINGUAS}; do
		if hasq ${LANG} ${LANGS//-/_} en; then
			hasq ${LANG//_/-} ${linguas} || \
				linguas="${linguas} ${LANG//_/-}"
			continue
		else
			local SLANG
			for SLANG in ${SHORTLANGS}; do
				if [[ ${LANG} == ${SLANG%%-*} ]]; then
					hasq ${SLANG} ${linguas} || \
						linguas="${linguas} ${SLANG}"
					continue 2
				fi
			done
		fi
		ewarn "Sorry, but mozilla-firefox does not support the ${LANG} LINGUA"
	done
}

src_unpack() {
	unpack firefox-${PV}.tar.gz

	linguas
	for X in ${linguas}; do
		[[ ${X} != en ]] && xpi_unpack firefox-${X}-${PV}.xpi
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
		[[ ${X} != en ]] && xpi_install ${WORKDIR}/firefox-${X}-${PV}
	done

	local LANG=${linguas%% *}
	if [[ ${LANG} != "" && ${LANG} != "en" ]]; then
		ebegin "Setting default locale to ${LANG}"
		sed -i "s:pref(\"general.useragent.locale\", \"en-US\"):pref(\"general.useragent.locale\", \"${LANG}\"):" \
			${D}${MOZILLA_FIVE_HOME}/defaults/pref/firefox.js \
			${D}${MOZILLA_FIVE_HOME}/defaults/pref/firefox-l10n.js
		eend $? || die "sed failed to change locale"
	fi

	# Create /usr/bin/firefox-bin
	install_mozilla_launcher_stub firefox-bin ${MOZILLA_FIVE_HOME}

	# Install icon and .desktop for menu entry
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/icon/mozillafirefox-bin-icon.png
	insinto /usr/share/applications
	doins ${FILESDIR}/icon/mozillafirefox-bin.desktop
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
