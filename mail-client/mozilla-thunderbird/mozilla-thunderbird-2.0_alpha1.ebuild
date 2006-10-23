# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mozilla-thunderbird/mozilla-thunderbird-2.0_alpha1.ebuild,v 1.1 2006/10/23 22:25:38 peper Exp $

#
# There are no linguas supported in alpha builds
# Anarchy ( Jory A. Pratt )
#

unset ALLOWED_FLAGS	 # stupid extra-functions.sh ... bug 49179
inherit flag-o-matic toolchain-funcs eutils mozconfig-2 mozilla-launcher makeedit multilib autotools mozextension

#LANGS="bg ca cs da de el en-GB es-AR es-ES eu fi fr ga-IE gu-IN he hu it ja ko lt mk nb-NO nl pa-IN pl pt-BR ru sk sl sv-SE tr zh-CN"
#SHORTLANGS="es-ES ga-IE nb-NO sv-SE"
PVER="1.0"
MY_PV=${PV/_alpha1/a1}

DESCRIPTION="Thunderbird Mail Client"
HOMEPAGE="http://www.mozilla.org/projects/thunderbird/"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/thunderbird/releases/${MY_PV}/source/thunderbird-${MY_PV}-source.tar.bz2
	http://gentooexperimental.org/~genstef/dist/${P}-patches-${PVER}.tar.bz2"

KEYWORDS="~amd64 ~ia64 ~mips ~ppc ~sparc ~x86 ~x86-fbsd"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"
IUSE="ldap crypt branding mozdom"

#for X in ${LANGS} ; do
#	SRC_URI="${SRC_URI} linguas_${X/-/_}? ( mirror://gentoo/thunderbird-${X}-${PV}.xpi )"
#	IUSE="${IUSE} linguas_${X/-/_}"
#done

#for X in ${SHORTLANGS} ; do
#	SRC_URI="${SRC_URI} linguas_${X%%-*}? ( mirror://gentoo/thunderbird-${X}-${PV}.xpi )"
#	IUSE="${IUSE} linguas_${X%%-*}"
#done

RDEPEND=">=www-client/mozilla-launcher-1.39
	>=dev-libs/nss-3.10
	>=dev-libs/nspr-4.6.1
	~sys-devel/autoconf-2.13"

PDEPEND="crypt? ( x11-plugins/enigmail )"

S=${WORKDIR}/mozilla

# Needed by src_compile() and src_install().
# Would do in pkg_setup but that loses the export attribute, they
# become pure shell variables.
export BUILD_OFFICIAL=1
export MOZILLA_OFFICIAL=1
export MOZ_CO_PROJECT=mail

#linguas() {
#	linguas=
#	local LANG
#	for LANG in ${LINGUAS}; do
#		if hasq ${LANG} en en_US; then
#			hasq en ${linguas} || \
#				linguas="${linguas:+"${linguas} "}en"
#			continue
#		elif hasq ${LANG} ${LANGS//-/_}; then
#			hasq ${LANG//_/-} ${linguas} || \
#				linguas="${linguas:+"${linguas} "}${LANG//_/-}"
#			continue
#		else
#			local SLANG
#			for SLANG in ${SHORTLANGS}; do
#				if [[ ${LANG} == ${SLANG%%-*} ]]; then
#					hasq ${SLANG} ${linguas} || \
#						linguas="${linguas:+"${linguas} "}${SLANG}"
#					continue 2
#				fi
#			done
#		fi
#		ewarn "Sorry, but mozilla-thunderbird does not support the ${LANG} LINGUA"
#	done
#}

src_unpack() {
	unpack thunderbird-${MY_PV}-source.tar.bz2 ${P}-patches-${PVER}.tar.bz2

#	linguas
#	for X in ${linguas}; do
#		[[ ${X} != en ]] && xpi_unpack thunderbird-${X}-${PV}.xpi
#	done

	cd ${S} || die "cd failed"

	# Apply our patches
	EPATCH_FORCE="yes" epatch "${WORKDIR}"/patch

	# Fix a compilation issue using the 32-bit userland with 64-bit kernel on
	# PowerPC, because with that configuration, it detects a ppc64 system.
	# -- hansmi, 2005-11-13
	if use ppc && [[ "${PROFILE_ARCH}" == ppc64 ]]; then
		sed -i -e "s#OS_TEST=\`uname -m\`\$#OS_TEST=${ARCH}#" \
			${S}/configure
		sed -i -e "s#OS_TEST :=.*uname -m.*\$#OS_TEST:=${ARCH}#" \
			${S}/security/coreconf/arch.mk
	fi

	WANT_AUTOCONF="2.1" \
		eautoreconf || die "failed running autoreconf"
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

	# tb-specific settings
	mozconfig_use_enable ldap
	mozconfig_use_enable ldap ldap-experimental
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}
	mozconfig_annotate '' --with-user-appdir=.thunderbird
	mozconfig_annotate '' --with-system-nspr
	mozconfig_annotate '' --with-system-nss

	# Bug #72667
	if use mozdom; then
		mozconfig_annotate '' --enable-extensions=default,inspector
	else
		mozconfig_annotate '' --enable-extensions=default
	fi

	if use branding; then
		mozconfig_annotate '' --enable-official-branding
	fi

	# Finalize and report settings
	mozconfig_final

	# hardened GCC uses -fstack-protector-all by default, which breaks us
	gcc-specs-ssp && append-flags -fno-stack-protector-all
	replace-flags -fstack-protector-all -fstack-protector

	####################################
	#
	#  Configure and build
	#
	####################################
	append-flags -freorder-blocks -fno-reorder-functions

	CPPFLAGS="${CPPFLAGS}" \
	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" \
	econf || die "econf failed"

	# This removes extraneous CFLAGS from the Makefiles to reduce RAM
	# requirements while compiling
	edit_makefiles

	emake || die "emake failed"
}

pkg_preinst() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	echo ""
	einfo "Removing old installs though some really ugly code.  It potentially"
	einfo "eliminates any problems during the install, however suggestions to"
	einfo "replace this are highly welcome.  Send comments and suggestions to"
	einfo "mozilla@gentoo.org"
	rm -rf ${ROOT}${MOZILLA_FIVE_HOME}
	echo ""
}

src_install() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	# Most of the installation happens here
	dodir ${MOZILLA_FIVE_HOME}
	cp -RL "${S}/dist/bin/"* "${D}${MOZILLA_FIVE_HOME}" || die "Copy of files failed"

#	linguas
#	for X in ${linguas}; do
#		[[ ${X} != en ]] && xpi_install ${WORKDIR}/thunderbird-${X}-${PV}
#	done

#	local LANG=${linguas%% *}
#	if [[ ${LANG} != "" && ${LANG} != "en" ]]; then
#		ebegin "Setting default locale to ${LANG}"
#		sed -i "s:pref(\"general.useragent.locale\", \"en-US\"):pref(\"general.useragent.locale\", \"${LANG}\"):" \
#			${D}${MOZILLA_FIVE_HOME}/defaults/pref/all-thunderbird.js \
#			${D}${MOZILLA_FIVE_HOME}/defaults/pref/all-l10n.js
#		eend $? || die "sed failed to change locale"
#	fi

	# Create directory structure to support portage-installed extensions.
	# See update_chrome() in mozilla-launcher
	keepdir ${MOZILLA_FIVE_HOME}/chrome.d
	keepdir ${MOZILLA_FIVE_HOME}/extensions.d
	cp ${D}${MOZILLA_FIVE_HOME}/chrome/installed-chrome.txt \
		${D}${MOZILLA_FIVE_HOME}/chrome.d/0_base-chrome.txt

	# Create /usr/bin/thunderbird
	install_mozilla_launcher_stub thunderbird ${MOZILLA_FIVE_HOME}

	# Install icon and .desktop for menu entry
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/icon/thunderbird-icon.png

	# Fix bug 54179: Install .desktop file into /usr/share/applications
	# instead of /usr/share/gnome/apps/Internet (18 Jun 2004 agriffis)
	insinto /usr/share/applications
	doins ${FILESDIR}/icon/mozillathunderbird.desktop

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
}

pkg_postinst() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	# This should be called in the postinst and postrm of all the
	# mozilla, mozilla-bin, firefox, firefox-bin, thunderbird and
	# thunderbird-bin ebuilds.
	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	update_mozilla_launcher_symlinks
}
