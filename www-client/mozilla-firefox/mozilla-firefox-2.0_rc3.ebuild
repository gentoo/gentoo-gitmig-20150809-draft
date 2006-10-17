# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/mozilla-firefox/mozilla-firefox-2.0_rc3.ebuild,v 1.2 2006/10/17 16:55:19 gothgirl Exp $

inherit flag-o-matic toolchain-funcs eutils mozconfig-2 mozilla-launcher makeedit multilib fdo-mime mozextension autotools

PATCH="mozilla-firefox-2.0_rc1-patches-1.4"
LANGS="ar be bg ca cs da de el en-GB es-AR es-ES eu fi fr fy-NL ga-IE gu-IN hu
it ja ko lt mk mn nb-NO nl nn-NO pa-IN pl pt-BR pt-PT ru sk sl sv-SE tr zh-CN
zh-TW"
NOSHORTLANGS="en-GB es-AR pt-BR zh-TW"
MY_PV=${PV/_}

DESCRIPTION="Firefox Web Browser"
HOMEPAGE="http://www.mozilla.org/projects/firefox/"

KEYWORDS="~alpha ~amd64 ~sparc ~x86 ~ppc"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"
IUSE="java mozdevelop branding xforms"

MOZ_URI="http://releases.mozilla.org/pub/mozilla.org/firefox/releases/${MY_PV}"
SRC_URI="${MOZ_URI}/source/firefox-${MY_PV}-source.tar.bz2
	http://gentooexperimental.org/~genstef/dist/${PATCH}.tar.bz2"

# These are in
#
#  http://releases.mozilla.org/pub/mozilla.org/firefox/releases/${MY_PV}/linux-i686/xpi/
#
# for i in $LANGS $SHORTLANGS; do wget $i.xpi -O ${P}-$i.xpi; done
for X in ${LANGS} ; do
	SRC_URI="${SRC_URI}
		linguas_${X/-/_}? ( http://gentooexperimental.org/~genstef/dist/${P}-xpi/${P}-${X}.xpi )"
	IUSE="${IUSE} linguas_${X/-/_}"
	# english is handled internally
	if [ "${#X}" == 5 ] && ! has ${X} ${NOSHORTLANGS}; then
		SRC_URI="${SRC_URI}
			linguas_${X%%-*}? ( http://gentooexperimental.org/~genstef/dist/${P}-xpi/${P}-${X}.xpi )"
		IUSE="${IUSE} linguas_${X%%-*}"
	fi
done

RDEPEND="java? ( virtual/jre )
	>=www-client/mozilla-launcher-1.39
	>=sys-devel/binutils-2.16.1
	>=dev-libs/nss-3.11.1-r1
	>=dev-libs/nspr-4.6.1
	~sys-devel/autoconf-2.13"

DEPEND="${RDEPEND}
	java? ( >=dev-java/java-config-0.2.0 )"

S="${WORKDIR}/mozilla"

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

pkg_setup(){
	if use branding; then
		einfo "You are enabling official branding. You may not redistribute this build"
		einfo "to any users on your network or the internet. Doing so puts yourself into"
		einfo "a legal problem with mozilla foundation"
	fi
}

src_unpack() {
	unpack ${A%bz2*}bz2

	linguas
	for X in ${linguas}; do
		[[ ${X} != "en" ]] && xpi_unpack "${P}-${X}.xpi"
	done

	cd "${S}"

	# Apply our patches
	EPATCH_FORCE="yes" epatch "${WORKDIR}"/patch

	# Fix a compilation issue using the 32-bit userland with 64-bit kernel on
	# PowerPC, because with that configuration, it detects a ppc64 system.
	# -- hansmi, 2005-11-13
	if use ppc && [[ "${PROFILE_ARCH}" == ppc64 ]]; then
		sed -i -e "s#OS_TEST=\`uname -m\`\$#OS_TEST=${ARCH}#" \
			"${S}"/configure
		sed -i -e "s#OS_TEST :=.*uname -m.*\$#OS_TEST:=${ARCH}#" \
			"${S}"/security/coreconf/arch.mk
	fi

	WANT_AUTOCONF="2.1" eautoreconf
}

src_compile() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	mozconfig_init
	mozconfig_config

	mozconfig_annotate '' --enable-application=browser
	mozconfig_annotate '' --enable-image-encoder=all
	mozconfig_annotate '' --enable-canvas
	mozconfig_annotate '' --with-system-nspr
	mozconfig_annotate '' --with-system-nss

	if use xforms; then
		mozconfig_annotate '' --enable-extensions=default,xforms,schema-validation,typeaheadfind
	else
		mozconfig_annotate '' --enable-extensions=default,typeaheadfind
	fi

	if use branding; then
		mozconfig_annotate '' --enable-official-branding
	fi

	# Bug 60668: Galeon doesn't build without oji enabled, so enable it
	# regardless of java setting.
	mozconfig_annotate '' --enable-oji --enable-mathml

	# Other ff-specific settings
	mozconfig_use_enable mozdevelop jsd
	mozconfig_use_enable mozdevelop xpctools
	mozconfig_use_extension mozdevelop venkman
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}

	# Add build variables
	mozconfig_build_opts

	# Finalize and report settings
	mozconfig_final

	# -fstack-protector breaks us
	if gcc-version ge 4 1; then
		gcc-specs-ssp && append-flags -fno-stack-protector
	else
		gcc-specs-ssp && append-flags -fno-stack-protector-all
	fi
		filter-flags -fstack-protector -fstack-protector-all

	####################################
	#
	#  Configure and build
	#
	####################################

	CPPFLAGS="${CPPFLAGS} -DARON_WAS_HERE" \
	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" \
	econf || die

	# It would be great if we could pass these in via CPPFLAGS or CFLAGS prior
	# to econf, but the quotes cause configure to fail.
	sed -i -e \
		's|-DARON_WAS_HERE|-DGENTOO_NSPLUGINS_DIR=\\\"/usr/'"$(get_libdir)"'/nsplugins\\\" -DGENTOO_NSBROWSER_PLUGINS_DIR=\\\"/usr/'"$(get_libdir)"'/nsbrowser/plugins\\\"|' \
		${S}/config/autoconf.mk \
		${S}/xpfe/global/buildconfig.html

	# This removes extraneous CFLAGS from the Makefiles to reduce RAM
	# requirements while compiling
	edit_makefiles

	emake || die
}

pkg_preinst() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	einfo "Removing old install to eliminate any problems during install."
	rm -rf "${ROOT}"/"${MOZILLA_FIVE_HOME}"
}

src_install() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	# Most of the installation happens here
	dodir "${MOZILLA_FIVE_HOME}"
	cp -RL "${S}"/dist/bin/* "${D}"/"${MOZILLA_FIVE_HOME}"/ || die "cp failed"

	linguas
	for X in ${linguas}; do
		[[ ${X} != "en" ]] && xpi_install "${WORKDIR}"/"${P}-${X}"
	done

	local LANG=${linguas%% *}
	if [[ -n ${LANG} && ${LANG} != "en" ]]; then
		einfo "Setting default locale to ${LANG}"
		dosed -e "s:general.useragent.locale\", \"en-US\":general.useragent.locale\", \"${LANG}\":" \
			"${MOZILLA_FIVE_HOME}"/defaults/pref/firefox.js \
			"${MOZILLA_FIVE_HOME}"/defaults/pref/firefox-l10n.js || \
			die "sed failed to change locale"
	fi

	# Create /usr/bin/firefox
	install_mozilla_launcher_stub firefox "${MOZILLA_FIVE_HOME}"

	# Install icon and .desktop for menu entry
	doicon "${FILESDIR}"/icon/firefox-icon.png
	newmenu "${FILESDIR}"/icon/mozillafirefox-1.5.desktop \
		mozillafirefox-2.0.desktop

	# Fix icons to look the same everywhere
	insinto "${MOZILLA_FIVE_HOME}"/icons
	doins "${S}"/dist/branding/mozicon16.xpm
	doins "${S}"/dist/branding/mozicon50.xpm


	# Install files necessary for applications to build against firefox
	einfo "Installing includes and idl files..."
	dodir "${MOZILLA_FIVE_HOME}"/idl "${MOZILLA_FIVE_HOME}"/include
	cp -LfR "${S}"/dist/include/* "${D}"/"${MOZILLA_FIVE_HOME}"/include/ || \
		die "cp failed"
	cp -LfR "${S}"/dist/idl/* "${D}"/"${MOZILLA_FIVE_HOME}"/idl || \
		die "cp failed"

	# Dirty hack to get some applications using this header running
	dosym "${MOZILLA_FIVE_HOME}"/include/necko/nsIURI.h \
		"${MOZILLA_FIVE_HOME}"/include/nsIURI.h

	# Install pkgconfig files
	insinto /usr/"$(get_libdir)"/pkgconfig
	doins "${S}"/build/unix/*.pc

	insinto "${MOZILLA_FIVE_HOME}"/greprefs
	newins "${FILESDIR}"/gentoo-default-prefs.js all-gentoo.js
	insinto "${MOZILLA_FIVE_HOME}"/defaults/pref
	newins "${FILESDIR}"/gentoo-default-prefs.js all-gentoo.js
}

pkg_postinst() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	# This should be called in the postinst and postrm of all the
	# mozilla, mozilla-bin, firefox, firefox-bin, thunderbird and
	# thunderbird-bin ebuilds.
	update_mozilla_launcher_symlinks

	# Update mimedb for the new .desktop file
	fdo-mime_desktop_database_update

	elog "Please remember to rebuild any packages that you have built"
	elog "against firefox. Some packages might be broken by the upgrade; if this"
	elog "is the case, please search at http://bugs.gentoo.org and open a new bug"
	elog "if one does not exist. Before filing any bugs, please move or remove ~/.mozilla"
	elog "and test with a clean profile directory."
}

pkg_postrm() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	update_mozilla_launcher_symlinks
}
