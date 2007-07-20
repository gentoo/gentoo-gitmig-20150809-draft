# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/mozilla-sunbird-bin/mozilla-sunbird-bin-0.5.ebuild,v 1.5 2007/07/20 11:56:28 armin76 Exp $

inherit eutils mozilla-launcher multilib mozextension

LANGS="ca cs da de es-ES eu fr ga-IE hu it mk mn nb-NO nl pa-IN pl pt-BR ru sk sl sv-SE"

MY_PN="${PN/mozilla-}"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Mozilla Sunbird Calendar"
SRC_URI="http://releases.mozilla.org/pub/mozilla.org/calendar/sunbird/releases/${PV}/linux-i686/en-US/sunbird-${PV}.en-US.linux-i686.tar.gz"
HOMEPAGE="http://www.mozilla.org/projects/calendar/sunbird.html"
RESTRICT="strip"

KEYWORDS="-* ~amd64 x86"
SLOT="0"
LICENSE="MPL-1.1 GPL-2 LGPL-2.1"
IUSE=""

# These are in
#
#  http://releases.mozilla.org/pub/mozilla.org/calendar/sunbird/releases/${PV}/langpacks/
#
# for i in $LANGS $SHORTLANGS; do wget $i.xpi -O ${P}-$i.xpi; done
#for X in ${LANGS} ; do
#	SRC_URI="${SRC_URI}
#		linguas_${X/-/_}? ( http://dev.gentooexperimental.org/~armin76/dist/${P/-bin/}-xpi/${P/-bin/}-${X}.xpi )"
#	IUSE="${IUSE} linguas_${X/-/_}"
	# english is handled internally
#done
for X in ${LANGS} ; do
	SRC_URI="${SRC_URI}
		linguas_${X/-/_}? ( http://dev.gentooexperimental.org/~armin76/dist/${P/-bin}-xpi/${P/-bin/}-${X}.xpi )"
	IUSE="${IUSE} linguas_${X/-/_}"
	# english is handled internally
	if [ "${#X}" == 5 ] && ! has ${X} ${NOSHORTLANGS}; then
		SRC_URI="${SRC_URI}
			linguas_${X%%-*}? ( http://dev.gentooexperimental.org/~armin76/dist/${P/-bin}-xpi/${P/-bin/}-${X}.xpi )"
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

src_unpack() {
	unpack ${MY_PN/-bin}-${PV}.en-US.linux-i686.tar.gz

	for X in ${A}; do
		[[ ${X} == *.xpi ]] && xpi_unpack ${X}
	done
}

src_install() {
	declare MOZILLA_FIVE_HOME=/opt/sunbird

	# Install sunbird in /opt
	dodir ${MOZILLA_FIVE_HOME%/*}
	touch ${S}/extensions/talkback@mozilla.org/chrome.manifest
	mv ${S} ${D}${MOZILLA_FIVE_HOME}

	# Install langpacks
	for X in ${A}; do
		[[ ${X} == *.xpi ]] && xpi_install "${WORKDIR}"/${X%.xpi}
	done

	# Use a langpack depending on the system locale
	for i in ${D}/"${MOZILLA_FIVE_HOME}"/greprefs/all-gentoo.js \
		${D}"${MOZILLA_FIVE_HOME}"/defaults/pref/all-gentoo.js;	do
		echo 'pref("intl.locale.matchOS",                true);' >> $i
	done

	# Create /usr/bin/sunbird-bin
	install_mozilla_launcher_stub sunbird-bin ${MOZILLA_FIVE_HOME}

	# Install icon and .desktop for menu entry
	doicon ${FILESDIR}/icon/${PN}-icon.png
	domenu ${FILESDIR}/icon/${PN}.desktop
}

pkg_preinst() {
	declare MOZILLA_FIVE_HOME=/opt/sunbird

	# Remove entire installed instance to prevent all kinds of
	# problems... see bug 44772 for example
	rm -rf ${ROOT}${MOZILLA_FIVE_HOME}
}

pkg_postinst() {
	use amd64 && einfo "NB: You just installed a 32-bit sunbird"
	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	update_mozilla_launcher_symlinks
}
