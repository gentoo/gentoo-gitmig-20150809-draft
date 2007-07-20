# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mozilla-thunderbird-bin/mozilla-thunderbird-bin-2.0.0.5.ebuild,v 1.1 2007/07/20 15:50:50 armin76 Exp $

inherit eutils mozilla-launcher multilib mozextension

LANGS="be bg ca cs da de el en-GB es-AR es-ES eu fi fr ga-IE hu it ja lt mk nb-NO nl nn-NO pa-IN pl pt-BR pt-PT ru sk sl sv-SE tr zh-CN zh-TW"
NOSHORTLANGS="en-GB es-AR pt-BR zh-TW"

DESCRIPTION="Thunderbird Mail Client"
SRC_URI="http://releases.mozilla.org/pub/mozilla.org/thunderbird/releases/${PV}/linux-i686/en-US/thunderbird-${PV}.tar.gz"
HOMEPAGE="http://www.mozilla.com/thunderbird"
RESTRICT="strip"

KEYWORDS="-* ~amd64 ~x86"
SLOT="0"
LICENSE="MPL-1.1 GPL-2 LGPL-2.1"
IUSE=""

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
	>=www-client/mozilla-launcher-1.41"

S="${WORKDIR}/thunderbird"

pkg_setup() {
	# This is a binary x86 package => ABI=x86
	# Please keep this in future versions
	# Danny van Dyk <kugelfang@gentoo.org> 2005/03/26
	has_multilib_profile && ABI="x86"
}

src_unpack() {
	unpack thunderbird-${PV}.tar.gz

	for X in ${A}; do
		[[ ${X} == *.xpi ]] && xpi_unpack ${X}
	done
}

src_install() {
	declare MOZILLA_FIVE_HOME=/opt/thunderbird

	# Install thunderbird in /opt
	dodir ${MOZILLA_FIVE_HOME%/*}
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

	# Install /usr/bin/thunderbird-bin
	install_mozilla_launcher_stub thunderbird-bin ${MOZILLA_FIVE_HOME}

	# Install icon and .desktop for menu entry
	doicon ${FILESDIR}/icon/${PN}-icon.png
	domenu ${FILESDIR}/icon/${PN}.desktop

	# revdep-rebuild entry
	insinto /etc/revdep-rebuild
	doins ${FILESDIR}/10thunderbird-bin

	# install ldpath env.d
	doenvd ${FILESDIR}/71thunderbird-bin
}

pkg_preinst() {
	declare MOZILLA_FIVE_HOME=/opt/thunderbird

	# Remove entire installed instance to solve various
	# problems, for example see bug 27719
	rm -rf ${ROOT}${MOZILLA_FIVE_HOME}
}

pkg_postinst() {
	elog "For enigmail, please see instructions at"
	elog "  http://enigmail.mozdev.org/"

	use amd64 && einfo "NB: You just installed a 32-bit thunderbird"
	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	update_mozilla_launcher_symlinks
}
