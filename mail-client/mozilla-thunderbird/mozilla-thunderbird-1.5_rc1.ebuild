# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mozilla-thunderbird/mozilla-thunderbird-1.5_rc1.ebuild,v 1.3 2005/11/16 22:58:29 anarchy Exp $

unset ALLOWED_FLAGS  # stupid extra-functions.sh ... bug 49179
inherit flag-o-matic toolchain-funcs eutils mozconfig-2 mozilla-launcher makeedit multilib versionator

MY_P="$(replace_version_separator 2 '')"
TV=${MY_P/beta/b}

DESCRIPTION="Thunderbird Mail Client"
HOMEPAGE="http://www.mozilla.org/projects/thunderbird/"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/thunderbird/releases/${TV}/source/thunderbird-${TV}-source.tar.bz2
	mirror://gentoo/mozilla-firefox-1.0-4ft2.patch.bz2
	mirror://gentoo/mozilla-jslibmath-alpha.patch"

KEYWORDS="-*"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"
IUSE="ldap"

RDEPEND=">=www-client/mozilla-launcher-1.39"

S=${WORKDIR}/mozilla

# Needed by src_compile() and src_install().
# Would do in pkg_setup but that loses the export attribute, they
# become pure shell variables.
export BUILD_OFFICIAL=1
export MOZILLA_OFFICIAL=1
export MOZ_CO_PROJECT=mail

src_unpack() {
	declare x

	for x in ${A}; do
		[[ $x == *.tar.* ]] || continue
		unpack $x || die "unpack failed"
	done
	cd ${S} || die "cd failed"

	####################################
	#
	# architecture patches
	#
	####################################

	# amd64 visibility patch
	if [[ ${ARCH} == amd64 ]] && [[ $(gcc-major-version) -ge 3 ]]; then
		epatch ${FILESDIR}/thunderbird-visibility.patch
	fi

	# patch to fix math operations on alpha, makes maps.google.com work!
	epatch ${DISTDIR}/mozilla-jslibmath-alpha.patch

	####################################
	#
	# general compilation and run-time fixes
	#
	####################################

	# patch from fedora to remove the pangoxft things
	epatch ${FILESDIR}/thunderbird-nopangoxft.patch
	#cairo-canvas patch
	epatch ${FILESDIR}/thunderbird-cairo-canvas.patch

	# rpath fix
	epatch ${FILESDIR}/thunderbird-rpath-1.patch

	# Fix a compilation issue using the 32-bit userland with 64-bit kernel on
	# PowerPC, because with that configuration, it detects a ppc64 system.
	# -- hansmi, 2005-11-13
	if use ppc && [[ "${PROFILE_ARCH}" == ppc64 ]]; then
		sed -i -e "s#OS_TEST=\`uname -m\`\$#OS_TEST=${ARCH}#" \
			${S}/configure
		sed -i -e "s#OS_TEST :=.*uname -m.*\$#OS_TEST:=${ARCH}#" \
			${S}/security/coreconf/arch.mk
	fi

	echo  ""
	ewarn "This thunderbird-1.5rc1 ebuild is provided for your convenience,"
	ewarn "the use of this ebuild is not supported by gentoo developers. "
	ewarn "Please file bugs related to firefox-1.5 with upstream developers."
	ewarn "Bugs should be filed @ https://bugzilla.mozilla.org."
	ewarn "Thank you Anarchy"
}

src_compile() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	mozconfig_init

	# tb-specific settings
	mozconfig_use_enable ldap
	mozconfig_use_enable ldap ldap-experimental
	mozconfig_annotate '' --enable-extensions=default
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}
	mozconfig_annotate '' --with-user-appdir=.thunderbird

	# Finalize and report settings
	mozconfig_final

	# hardened GCC uses -fstack-protector-all by default, which breaks us
	has_hardened && append-flags -fno-stack-protector-all
	replace-flags -fstack-protector-all -fstack-protector

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
		${S}/nsprpub/config/autoconf.mk \
		${S}/xpfe/global/buildconfig.html

	# Fixup the RPATH
	sed -i -e \
		's|#RPATH_FIXER|'"${MOZILLA_FIVE_HOME}"'|' \
		${S}/config/rules.mk \
		${S}/nsprpub/config/rules.mk \
		${S}/security/coreconf/rules.mk \
		${S}/security/coreconf/rules.mk


	# This removes extraneous CFLAGS from the Makefiles to reduce RAM
	# requirements while compiling
	edit_makefiles

	emake || die
}

src_install() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	# Most of the installation happens here
	dodir ${MOZILLA_FIVE_HOME}
	cp -RL --no-preserve=links ${S}/dist/bin/* ${D}${MOZILLA_FIVE_HOME}

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
}

pkg_postinst() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	# This should be called in the postinst and postrm of all the
	# mozilla, mozilla-bin, firefox, firefox-bin, thunderbird and
	# thunderbird-bin ebuilds.
	update_mozilla_launcher_symlinks

	echo  ""
	ewarn "Enigmail Support has been dropped since it doesn't work on fresh install."
	ewarn "The Gentoo Mozilla team is working on making enigmail its own build,"
	ewarn "sorry for the inconvenience.  For now, you can download enigmail from"
	ewarn "http://enigmail.mozdev.org"

	echo  ""
	ewarn "This thunderbird-1.5rc1 ebuild is provided for your convenience,"
	ewarn "the use of this ebuild is not supported by gentoo developers. "
	ewarn "Please file bugs related to firefox-1.5 with upstream developers."
	ewarn "Bugs should be filed @ https://bugzilla.mozilla.org."
	ewarn "Thank you Anarchy"
}

pkg_postrm() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	update_mozilla_launcher_symlinks
}
