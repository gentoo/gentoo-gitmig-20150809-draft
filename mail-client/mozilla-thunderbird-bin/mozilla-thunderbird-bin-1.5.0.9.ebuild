# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mozilla-thunderbird-bin/mozilla-thunderbird-bin-1.5.0.9.ebuild,v 1.1 2006/12/19 19:20:48 genstef Exp $

inherit eutils mozilla-launcher multilib

LANGS="bg ca cs da de el en-GB es-AR es-ES eu fi fr ga-IE gu-IN he hu it ja ko lt mk nb-NO nl pa-IN pl pt-BR ru sk sl sv-SE tr zh-CN"
SHORTLANGS="es-ES ga-IE nb-NO sv-SE"

DESCRIPTION="The Mozilla Thunderbird Mail & News Reader"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/thunderbird/releases/${PV}/linux-i686/en-US/thunderbird-${PV}.tar.gz"
HOMEPAGE="http://www.mozilla.org/projects/thunderbird"
RESTRICT="nostrip"

KEYWORDS="-* ~amd64 ~x86"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"
IUSE=""

for X in ${LANGS} ; do
	SRC_URI="${SRC_URI} linguas_${X/-/_}? (	http://dev.gentooexperimental.org/~anarchy/${P/-bin}-xpi/${P/-bin}-${X}.xpi )"
	IUSE="${IUSE} linguas_${X/-/_}"
done

for X in ${SHORTLANGS} ; do
	SRC_URI="${SRC_URI} linguas_${X%%-*}? (	http://dev.gentooexperimental.org/~anarchy/${P/-bin}-xpi//${P/-bin}-${X}.xpi )"
	IUSE="${IUSE} linguas_${X%%-*}"
done

DEPEND="virtual/libc"
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
		>=app-emulation/emul-linux-x86-baselibs-2.1.1
		>=app-emulation/emul-linux-x86-gtklibs-2.1
	)
	virtual/libstdc++
	>=www-client/mozilla-launcher-1.41"

S=${WORKDIR}/thunderbird

linguas() {
	linguas=
	local LANG
	for LANG in ${LINGUAS}; do
		if hasq ${LANG} en en_US; then
			hasq en ${linguas} || \
				linguas="${linguas:+"${linguas} "}en"
			continue
		elif hasq ${LANG} ${LANGS//-/_}; then
			hasq ${LANG//_/-} ${linguas} || \
				linguas="${linguas:+"${linguas} "}${LANG//_/-}"
			continue
		else
			local SLANG
			for SLANG in ${SHORTLANGS}; do
				if [[ ${LANG} == ${SLANG%%-*} ]]; then
					hasq ${SLANG} ${linguas} || \
						linguas="${linguas:+"${linguas} "}${SLANG}"
					continue 2
				fi
			done
		fi
		ewarn "Sorry, but mozilla-thunderbird does not support the ${LANG} LINGUA"
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
	for X in ${linguas}; do
		[[ ${X} != en ]] && xpi_unpack ${P/-bin}-${X}.xpi
	done
}

src_install() {
	declare MOZILLA_FIVE_HOME=/opt/thunderbird

	# Install thunderbird in /opt
	dodir ${MOZILLA_FIVE_HOME%/*}
	mv ${S} ${D}${MOZILLA_FIVE_HOME}

	linguas
	for X in ${linguas}; do
		[[ ${X} != en ]] && xpi_install ${WORKDIR}/${P/-bin}-${X}
	done

	local LANG=${linguas%% *}
	if [[ ${LANG} != "" && ${LANG} != "en" ]]; then
		ebegin "Setting default locale to ${LANG}"
		sed -i "s:pref(\"general.useragent.locale\", \"en-US\"):pref(\"general.useragent.locale\", \"${LANG}\"):" \
			${D}${MOZILLA_FIVE_HOME}/defaults/pref/all-thunderbird.js \
			${D}${MOZILLA_FIVE_HOME}/defaults/pref/all-l10n.js
		eend $? || die "sed failed to change locale"
	fi

	# Install /usr/bin/thunderbird-bin
	install_mozilla_launcher_stub thunderbird-bin ${MOZILLA_FIVE_HOME}

	# Install icon and .desktop for menu entry
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/icon/mozillathunderbird-bin-icon.png
	insinto /usr/share/applications
	doins ${FILESDIR}/icon/mozillathunderbird-bin.desktop

	# revdep-rebuild entry
	insinto /etc/revdep-rebuild
	doins ${FILESDIR}/10thunderbird-bin
}

pkg_preinst() {
	declare MOZILLA_FIVE_HOME=/opt/thunderbird

	# Remove entire installed instance to solve various
	# problems, for example see bug 27719
	rm -rf ${ROOT}${MOZILLA_FIVE_HOME}
}

pkg_postinst() {
	einfo "For enigmail, please see instructions at"
	einfo "  http://enigmail.mozdev.org/"

	if use amd64; then
		echo
		einfo "NB: You just installed a 32-bit thunderbird"
	fi

	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	update_mozilla_launcher_symlinks
}
