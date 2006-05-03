# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/mozilla-firefox/mozilla-firefox-1.5.0.3.ebuild,v 1.2 2006/05/03 02:27:28 anarchy Exp $

unset ALLOWED_FLAGS  # stupid extra-functions.sh ... bug 49179

inherit flag-o-matic toolchain-funcs eutils mozconfig-2 mozilla-launcher makeedit multilib fdo-mime mozextension autotools

LANGS="ar ca cs da de el en-GB es-AR es-ES fi fr ga-IE he hu it ja ko mk nb-NO nl pl pt-BR ro ru sk sl sv-SE tr zh-CN zh-TW"
SHORTLANGS="es-ES ga-IE nb-NO sv-SE"
PVER="1.0"

DESCRIPTION="Firefox Web Browser"
HOMEPAGE="http://www.mozilla.org/projects/firefox/"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${PV}/source/firefox-${PV}-source.tar.bz2
	mirror://gentoo/${P}-patches-${PVER}.tar.bz2
	http://dev.gentoo.org/~anarchy/dist/${P}-patches-${PVER}.tar.bz2"

for X in ${LANGS} ; do
	SRC_URI="${SRC_URI} linguas_${X/-/_}? ( mirror://gentoo/firefox-${X}-${PV}.xpi )"
done

for X in ${SHORTLANGS} ; do
	SRC_URI="${SRC_URI} linguas_${X%%-*}? ( mirror://gentoo/firefox-${X}-${PV}.xpi )"
done

KEYWORDS="-* amd64 ~ia64 ~ppc ~x86"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"
IUSE="java mozdevelop"

RDEPEND="java? ( virtual/jre )
	>=www-client/mozilla-launcher-1.39
	>=sys-devel/binutils-2.16.1
	>=dev-libs/nss-3.10
	>=dev-libs/nspr-4.6.1"

DEPEND="${RDEPEND}
	java? ( >=dev-java/java-config-0.2.0 )"

S=${WORKDIR}/mozilla

# Needed by src_compile() and src_install().
# Would do in pkg_setup but that loses the export attribute, they
# become pure shell variables.
export MOZ_CO_PROJECT=browser
export BUILD_OFFICIAL=1
export MOZILLA_OFFICIAL=1

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
	unpack firefox-${PV}-source.tar.bz2  ${P}-patches-${PVER}.tar.bz2

	linguas
	for X in ${linguas}; do
		[[ ${X} != en ]] && xpi_unpack firefox-${X}-${PV}.xpi
	done

	# Apply our patches
	cd ${S} || die "cd failed"
	EPATCH_FORCE="yes" epatch ${WORKDIR}/patch

	# Fix a compilation issue using the 32-bit userland with 64-bit kernel on
	# PowerPC, because with that configuration, it detects a ppc64 system.
	# -- hansmi, 2005-11-13
	if use ppc && [[ "${PROFILE_ARCH}" == ppc64 ]]; then
		sed -i -e "s#OS_TEST=\`uname -m\`\$#OS_TEST=${ARCH}#" \
			${S}/configure
		sed -i -e "s#OS_TEST :=.*uname -m.*\$#OS_TEST:=${ARCH}#" \
			${S}/security/coreconf/arch.mk
	fi

	WANT_AUTOCONF="2.13" \
		eautoreconf || die "failed  running eautoreconf"
}

src_compile() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	mozconfig_init
	mozconfig_config

	mozconfig_annotate '' --enable-extensions=default,typeaheadfind
	mozconfig_annotate '' --disable-mailnews
	#mozconfig_annotate '' --enable-native-uconv
	mozconfig_annotate '' --enable-image-encoder=all
	mozconfig_annotate ''  --enable-canvas
	mozconfig_annotate '' --with-system-nspr
	mozconfig_annotate '' --with-system-nss
	mozconfig_annotate '' --enable-official-branding

	# Bug 60668: Galeon doesn't build without oji enabled, so enable it
	# regardless of java setting.
	mozconfig_annotate '' --enable-oji --enable-mathml

	# Other ff-specific settings
	mozconfig_use_enable mozdevelop jsd
	mozconfig_use_enable mozdevelop xpctools
	mozconfig_use_extension mozdevelop venkman
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}

	# Finalize and report settings
	mozconfig_final

	# hardened GCC uses -fstack-protector-all by default, which breaks us
	gcc-specs-ssp && append-flags -fno-stack-protector-all
	# remove -fstack-protector because now it borks firefox
	CFLAGS=${CFLAGS/-fstack-protector-all/}
	CFLAGS=${CFLAGS/-fstack-protector/}
	CXXFLAGS=${CXXFLAGS/-fstack-protector-all/}
	CXXFLAGS=${CXXFLAGS/-fstack-protector/}

	append-flags -freorder-blocks -fno-reorder-functions

	# Export CPU_ARCH_TEST  as it is not exported by default.
	case $(tc-arch) in
	amd64) [[ ${ABI} == "x86" ]] && CPU_ARCH_TEST="x86" || CPU_ARCH_TEST="x86_64" ;;
	*) CPU_ARCH_TEST=$(tc-arch) ;;
	esac

	export CPU_ARCH_TEST

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
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	echo ""
	einfo "We are removing old install before we continue. This is to help"
	einfo "eliminate any problems during the install, sorry for those of you"
	einfo "who disagree with this but this will ensure a sane build for everyone"
	einfo "Comments and suggestion should be addressed to mozilla@gentoo.org"
	rm -rf ${ROOT}${MOZILLA_FIVE_HOME}
	echo ""
}

src_install() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	# Most of the installation happens here
	dodir ${MOZILLA_FIVE_HOME}
	cp -RL ${S}/dist/bin/* ${D}${MOZILLA_FIVE_HOME}

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

	# Create /usr/bin/firefox
	install_mozilla_launcher_stub firefox ${MOZILLA_FIVE_HOME}

	# Install icon and .desktop for menu entry
	doicon ${FILESDIR}/icon/firefox-icon.png
	domenu ${FILESDIR}/icon/mozillafirefox-1.5.desktop

	# Fix icons to look the same everywhere
	insinto ${MOZILLA_FIVE_HOME}/icons
	doins ${S}/dist/branding/mozicon16.xpm
	doins ${S}/dist/branding/mozicon50.xpm

	####################################
	#
	# Install files necessary for applications to build against firefox
	#
	####################################

	ewarn "Installing includes and idl files..."
	dodir ${MOZILLA_FIVE_HOME}/idl ${MOZILLA_FIVE_HOME}/include
	cd ${S}/dist
	cp -LfR include/* ${D}${MOZILLA_FIVE_HOME}/include || die "failed to copy"
	cp -LfR idl/* ${D}${MOZILLA_FIVE_HOME}/idl || die "failed to copy"

	# Dirty hack to get some applications using this header running
	dosym ${MOZILLA_FIVE_HOME}/include/necko/nsIURI.h \
		/usr/$(get_libdir)/${MOZILLA_FIVE_HOME##*/}/include/nsIURI.h


	# Fix pkgconfig files and install them
	insinto /usr/$(get_libdir)/pkgconfig
	for x in ${S}/build/unix/*.pc; do
		doins ${x}
	done

	####################################
	# 
	# Some preferences, probably gentoo.org as start-page also
	#
	####################################

	dodir ${MOZILLA_FIVE_HOME}/greprefs
	cp ${FILESDIR}/gentoo-default-prefs.js ${D}/${MOZILLA_FIVE_HOME}/greprefs/all-gentoo.js
	dodir ${MOZILLA_FIVE_HOME}/defaults/pref
	cp ${FILESDIR}/gentoo-default-prefs.js ${D}/${MOZILLA_FIVE_HOME}/defaults/pref/all-gentoo.js

	# Install docs
	dodoc LEGAL
}

pkg_postinst() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	# This should be called in the postinst and postrm of all the
	# mozilla, mozilla-bin, firefox, firefox-bin, thunderbird and
	# thunderbird-bin ebuilds.
	update_mozilla_launcher_symlinks

	# Update mimedb for the new .desktop file
	fdo-mime_desktop_database_update

	echo  ""
	ewarn "Please remember to rebuild any packages that you have built"
	ewarn "against firefox. Some packages might be broken by the upgrade; if this"
	ewarn "is the case, please search at http://bugs.gentoo.org and open a new bug"
	ewarn "if one does not exist. Before filing any bugs, please move or remove ~/.mozilla"
	ewarn "and test with a clean profile directory."
	ewarn "Thank you! anarchy@gentoo.org."

	echo     ""
	einfo "Any regchrome errors can be ignored right now, this is due to"
	einfo "mozilla-firefox-1.0.x. being unregistered with mozilla-launcher."

	epause 15
}

pkg_postrm() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	update_mozilla_launcher_symlinks
}
