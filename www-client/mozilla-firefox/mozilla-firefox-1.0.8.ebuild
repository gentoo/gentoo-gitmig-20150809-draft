# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/mozilla-firefox/mozilla-firefox-1.0.8.ebuild,v 1.5 2006/04/21 19:28:53 tcort Exp $

unset ALLOWED_FLAGS  # stupid extra-functions.sh ... bug 49179
MOZ_FREETYPE2="no"   # Need to disable for newer .. remove here and in mozconfig
	                 # when older is removed from tree.
MOZ_PANGO="yes"      # Need to enable for newer .. remove here and in mozconfig
	                 # when older is removed from tree.
inherit flag-o-matic toolchain-funcs eutils mozconfig mozilla-launcher makeedit multilib fdo-mime

PVER="1.0.8-patches-1.0"
SVGVER="2.3.10p1"

DESCRIPTION="Firefox Web Browser"
HOMEPAGE="http://www.mozilla.org/projects/firefox/"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${PV}/source/firefox-${PV}-source.tar.bz2
	mozsvg? (
		mirror://gentoo/moz_libart_lgpl-${SVGVER}.tar.bz2
		http://dev.gentoo.org/~azarah/mozilla/moz_libart_lgpl-${SVGVER}.tar.bz2
	)
	mirror://gentoo/${PN}-${PVER}.tar.bz2
	http://dev.gentoo.org/~anarchy/dist/${PN}-${PVER}.tar.bz2"

KEYWORDS="alpha ~amd64 ~arm ~hppa ~ia64 ppc sparc x86"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"
IUSE="gnome java mozdevelop mozsvg mozcalendar"

# xrender.pc appeared for the first time in xorg-x11-6.7.0-r2
# and is required to build with support for cairo.  #71504
RDEPEND="java? ( virtual/jre )
	>=media-libs/libmng-1.0.0
	mozsvg? ( !<x11-base/xorg-x11-6.7.0-r2 )
	>=www-client/mozilla-launcher-1.39"

DEPEND="${RDEPEND}
	java? ( >=dev-java/java-config-0.2.0 )"

S=${WORKDIR}/mozilla

# Needed by src_compile() and src_install().
# Would do in pkg_setup but that loses the export attribute, they
# become pure shell variables.
export BUILD_OFFICIAL=1
export MOZILLA_OFFICIAL=1
export MOZ_PHOENIX=1

src_unpack() {
	unpack firefox-${PV}-source.tar.bz2 ${PN}-${PVER}.tar.bz2
	cd ${S} || die "cd failed"

	if use mozsvg; then
		cd ${S}/other-licenses
		unpack moz_libart_lgpl-${SVGVER}.tar.bz2
	fi
	cd ${S}

	####################################
	#
	# patch collection
	#
	####################################

	# Need pango-1.10.0 stable
	rm -f ${WORKDIR}/patch/03[67]*
	epatch ${WORKDIR}/patch

	# Without 03[67]* patches, we need to link to pangoxft
	epatch ${FILESDIR}/mozilla-1.7.12-gtk2xft-link-pangoxft.patch

	# Fix scripts that call for /usr/local/bin/perl #51916
	ebegin "Patching smime to call perl from /usr/bin"
	sed -i -e '1s,usr/local/bin,usr/bin,' ${S}/security/nss/cmd/smimetools/smime
	eend $? || die "sed failed"

	# Fix a compilation issue using the 32-bit userland with 64-bit kernel on
	# PowerPC, because with that configuration, mozilla detects a ppc64 system.
	# -- hansmi, 2005-10-02
	if use ppc && [[ "${PROFILE_ARCH}" == ppc64 ]]; then
		sed -i -e "s#OS_TEST=\`uname -m\`\$#OS_TEST=${ARCH}#" \
			${S}/configure.in
		sed -i -e "s#OS_TEST :=.*uname -m.*\$#OS_TEST:=${ARCH}#" \
			${S}/security/coreconf/arch.mk
	fi

	# Needed by some of the patches
	WANT_AUTOCONF=2.1 autoconf || die "WANT_AUTOCONF failed"
}

src_compile() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	mozconfig_init

	# Bug 60668: Galeon doesn't build without oji enabled, so enable it
	# regardless of java setting.
	mozconfig_annotate '' --enable-oji --enable-mathml --enable-extensions=typeaheadfind

	# Other ff-specific settings
	mozconfig_use_enable mozdevelop jsd
	mozconfig_use_enable mozdevelop xpctools
	mozconfig_use_extension mozdevelop venkman
	mozconfig_use_enable gnome gnomevfs
	mozconfig_use_extension gnome gnomevfs
	mozconfig_use_enable mozcalendar calendar
	mozconfig_use_enable mozsvg svg
	mozconfig_use_enable mozsvg svg-renderer-libart
	use mozsvg && export MOZ_INTERNAL_LIBART_LGPL=1
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}
	#mozconfig_annotate '' --with-user-appdir=.firefox

	# Finalize and report settings
	mozconfig_final

	# hardened GCC uses -fstack-protector-all by default, which breaks us
	has_hardened && append-flags -fno-stack-protector-all
	# remove -fstack-protector because now it borks firefox
	CFLAGS=${CFLAGS/-fstack-protector-all/}
	CFLAGS=${CFLAGS/-fstack-protector/}
	CXXFLAGS=${CXXFLAGS/-fstack-protector-all/}
	CXXFLAGS=${CXXFLAGS/-fstack-protector/}

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
	cp -RL ${S}/dist/bin/* ${D}${MOZILLA_FIVE_HOME} || die "Failed to Copy"

	# Create directory structure to support portage-installed extensions.
	# See update_chrome() in mozilla-launcher
	keepdir ${MOZILLA_FIVE_HOME}/chrome.d
	cp ${D}${MOZILLA_FIVE_HOME}/chrome/installed-chrome.txt \
		${D}${MOZILLA_FIVE_HOME}/chrome.d/0_base-chrome.txt || die "Failed to Copy"
	dodir ${MOZILLA_FIVE_HOME}/extensions
	keepdir ${MOZILLA_FIVE_HOME}/extensions.d
	cp ${D}${MOZILLA_FIVE_HOME}/defaults/profile/extensions/installed-extensions.txt \
		${D}${MOZILLA_FIVE_HOME}/extensions.d/0_base-extensions.txt || die "Failed to Copy"
	cp ${D}${MOZILLA_FIVE_HOME}/defaults/profile/extensions/Extensions.rdf \
		${D}${MOZILLA_FIVE_HOME}/extensions/ || die "Failed to Copy"
	cp -RL ${D}${MOZILLA_FIVE_HOME}/defaults/profile/extensions/\{*\} \
		${D}${MOZILLA_FIVE_HOME}/extensions/ || die "Failed to Copy"

	# Create /usr/bin/firefox
	install_mozilla_launcher_stub firefox ${MOZILLA_FIVE_HOME}

	# Install icon and .desktop for menu entry
	doicon ${FILESDIR}/icon/firefox-icon.png
	domenu ${FILESDIR}/icon/mozillafirefox.desktop

	# Fix icons to look the same everywhere
	insinto ${MOZILLA_FIVE_HOME}/icons
	doins ${S}/dist/branding/mozicon16.xpm
	doins ${S}/dist/branding/mozicon50.xpm

	####################################
	#
	# Install files necessary for applications to build against firefox
	#
	####################################

	einfo "Installing includes and idl files..."
	dodir ${MOZILLA_FIVE_HOME}/{include,idl} /usr/include
	cd ${S}/dist
	cp -LfR include/* ${D}${MOZILLA_FIVE_HOME}/include || die "Failed to Copy"
	cp -LfR idl/* ${D}${MOZILLA_FIVE_HOME}/idl || die "Failed to Copy"

	# Dirty hack to get some applications using this header running
	dosym ${MOZILLA_FIVE_HOME}/include/necko/nsIURI.h \
		/usr/$(get_libdir)/${MOZILLA_FIVE_HOME##*/}/include/nsIURI.h

	# Compatibility symlink so that applications can still build against firefox
	# even though it has moved.  To remove this symlink, grep -r MozillaFirefox
	# /usr/portage and fix those ebuilds
	dosym ${MOZILLA_FIVE_HOME##*/} ${MOZILLA_FIVE_HOME%/*}/MozillaFirefox

	# Fix firefox-config and install it
	sed -i -e "s|/usr/$(get_libdir)/firefox-${PV}|${MOZILLA_FIVE_HOME}|g
		s|/usr/include/firefox-${PV}|${MOZILLA_FIVE_HOME}/include|g
		s|/usr/share/idl/firefox-${MY_PV}|${MOZILLA_FIVE_HOME}/idl|g
		s|%{idldir}|${MOZILLA_FIVE_HOME}/idl|g
		s|\(echo -L.*\)\($\)|\1 -Wl,-rpath,${MOZILLA_FIVE_HOME}\2|" \
		${S}/build/unix/firefox-config
	exeinto ${MOZILLA_FIVE_HOME}
	doexe ${S}/build/unix/firefox-config

	# Fix pkgconfig files and install them
	insinto /usr/$(get_libdir)/pkgconfig
	for x in ${S}/build/unix/*.pc; do
		sed -i -e "s|^libdir=.*|libdir=${MOZILLA_FIVE_HOME}|
			s|^includedir=.*|includedir=${MOZILLA_FIVE_HOME}/include|
			s|^idldir=.*|idldir=${MOZILLA_FIVE_HOME}/idl|
			s|\(Libs:.*\)\($\)|\1 -Wl,-rpath,\${libdir}\2|" ${x}
		doins ${x}
	done

	# Install env.d snippet, which isn't necessary for running firefox, but
	# might be necessary for programs linked against firefox
	insinto /etc/env.d
	doins ${FILESDIR}/10MozillaFirefox
	dosed "s|/usr/lib|/usr/$(get_libdir)|" /etc/env.d/10MozillaFirefox

	# Install manpage (from the Fedora package)
	doman ${FILESDIR}/firefox.1

	# Install docs
	dodoc ${S}/{LEGAL,LICENSE}
}

pkg_postinst() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	# Update the component registry
	MOZILLA_LIBDIR=${ROOT}${MOZILLA_FIVE_HOME} MOZILLA_LAUNCHER=firefox \
		/usr/libexec/mozilla-launcher -register

	# This should be called in the postinst and postrm of all the
	# mozilla, mozilla-bin, firefox, firefox-bin, thunderbird and
	# thunderbird-bin ebuilds.
	update_mozilla_launcher_symlinks

	# Update mimedb for the new .desktop file
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	# Update the component registry
	MOZILLA_LIBDIR=${ROOT}${MOZILLA_FIVE_HOME} MOZILLA_LAUNCHER=firefox \
		/usr/libexec/mozilla-launcher -register

	update_mozilla_launcher_symlinks

	# Update mimedb if .desktop file has been removed (uninstallation)
	[ -f ${ROOT}/usr/share/applications/mozillafirefox.desktop ] \
		|| fdo-mime_desktop_database_update
}
