# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/mozilla-firefox/mozilla-firefox-1.0.6-r6.ebuild,v 1.4 2005/08/18 19:53:19 anarchy Exp $

unset ALLOWED_FLAGS  # stupid extra-functions.sh ... bug 49179
inherit flag-o-matic toolchain-funcs eutils mozconfig mozilla-launcher makeedit multilib

DESCRIPTION="Firefox Web Browser"
HOMEPAGE="http://www.mozilla.org/projects/firefox/"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${PV}/source/firefox-${PV}-source.tar.bz2
	mirror://gentoo/mozilla-firefox-1.0-4ft2.patch.bz2
	mirror://gentoo/mozilla-firefox-1.0.3-ia64.patch.bz2
	mirror://gentoo/mozilla-jslibmath-alpha.patch
	http://dev.gentoo.org/~agriffis/dist/mozilla-1.7.10-nsplugins-v2.patch
	http://dev.gentoo.org/~anarchy/dist/embed-typeaheadfind.patch"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~sparc ~x86"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"
IUSE="gnome java mozdevelop mozsvg ssl"

# xrender.pc appeared for the first time in xorg-x11-6.7.0-r2
# and is required to build with support for cairo.  #71504
RDEPEND="java? ( virtual/jre )
	>=media-libs/libmng-1.0.0
	mozsvg? (
		!<=x11-base/xorg-x11-6.7.0-r2
		x11-libs/cairo
	)
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

	# alpha stubs patch from lfs project.
	# <taviso@gentoo.org> (26 Jun 2003)
	use alpha && epatch ${FILESDIR}/mozilla-1.3-alpha-stubs.patch

	# hppa patches from Ivar <orskaug@stud.ntnu.no>
	# <gmsoft@gentoo.org> (22 Dec 2004)
	epatch ${FILESDIR}/mozilla-hppa.patch

	# patch to solve segfaults on ia64, from Debian, originally from David
	# Mosberger
	epatch ${DISTDIR}/mozilla-firefox-1.0.3-ia64.patch.bz2

	# patch to fix math operations on alpha, makes maps.google.com work!
	epatch ${DISTDIR}/mozilla-jslibmath-alpha.patch

	####################################
	#
	# general compilation and run-time fixes
	#
	####################################

	# GCC4 compile fix, bug #87800
	epatch ${FILESDIR}/${P}-gcc4.patch

	# patch out ft caching code since the API changed between releases of
	# freetype; this enables freetype-2.1.8+ compat.
	# https://bugzilla.mozilla.org/show_bug.cgi?id=234035#c65
	epatch ${DISTDIR}/mozilla-firefox-1.0-4ft2.patch.bz2

	# Patch for newer versions of cairo #80301
	if has_version '>=x11-libs/cairo-0.3.0'; then
		epatch ${FILESDIR}/svg-cairo-0.3.0-fix.patch
	fi

	####################################
	#
	# behavioral fixes
	#
	####################################

	# patch to fix separate character on euro keyboards, bug 68995
	epatch ${FILESDIR}/mozilla-firefox-1.0-kp_separator.patch

	# some patches from Debian to set default preferences:
	# - inherit LANG from env
	# - shut off SSLv2 and 40-bit ciphers by default
	# - disable application auto-updating
	epatch ${FILESDIR}/mozilla-firefox-1.0.3-prefs.patch

	# look in /usr/lib/nsplugins for plugins, in addition to the usual places
	epatch ${DISTDIR}/mozilla-1.7.10-nsplugins-v2.patch

	# patch to fix crash in GtkPromptService::Prompt
	# https://bugzilla.mozilla.org/show_bug.cgi?id=265599
	epatch ${FILESDIR}/gtk-prompt-service.patch

	# patch to make prompts window modal instead of application modal
	# https://bugzilla.mozilla.org/show_bug.cgi?id=224454
	epatch ${FILESDIR}/embedprompter-modal.patch

	# patch to fix typeahead find for browsers which embed Firefox
	# http://bugzilla.gnome.org/show_bug.cgi?id=157435
	epatch ${DISTDIR}/embed-typeaheadfind.patch

	# patch to make the interface requestor give out its nsIDOMWindow
	# https://bugzilla.mozilla.org/show_bug.cgi?id=277587
	epatch ${FILESDIR}/securebrowserui-iirq.patch

	# patch to add border to tooltips
	# https://bugzilla.mozilla.org/show_bug.cgi?id=238052
	epatch ${FILESDIR}/gtk-tooltips.patch

	#rpath patch
	epatch ${FILESDIR}/mozilla-rpath-1.patch
}

src_compile() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	grep -Flr "#RPATH_FIXER" --include=*.mk . | xargs sed -i -e \
		's|#RPATH_FIXER|'"${MOZILLA_FIVE_HOME}"'|'

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
	mozconfig_use_enable mozsvg svg
	mozconfig_use_enable mozsvg svg-renderer-cairo
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}
	#mozconfig_annotate '' --with-user-appdir=.firefox

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
	grep -Flre -DARON_WAS_HERE --exclude=config.\* . | xargs sed -i -e \
	's|-DARON_WAS_HERE|-DGENTOO_NSPLUGINS_DIR=\\\"/usr/'"$(get_libdir)"'/nsplugins\\\" -DGENTOO_NSBROWSER_PLUGINS_DIR=\\\"/usr/'"$(get_libdir)"'/nsbrowser/plugins\\\"|'

	# This removes extraneous CFLAGS from the Makefiles to reduce RAM
	# requirements while compiling
	edit_makefiles

	emake || die
	####################################
	#
	#  Build Mozilla NSS
	#
	####################################

	# Build the NSS/SSL support
	if use ssl; then
		einfo "Building Mozilla-Firefox NSS..."

		# Fix #include problem
		cd ${S}/security/coreconf || die "cd coreconf failed"
		echo 'INCLUDES += -I$(DIST)/include/nspr -I$(DIST)/include/dbm'\
			>>headers.mk
		emake -j1 || die "make security headers failed"

		cd ${S}/security/nss || die "cd nss failed"
		emake -j1 moz_import || die "make moz_import failed"
		emake -j1 || die "make nss failed"
	fi

}

src_install() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	# Most of the installation happens here
	dodir ${MOZILLA_FIVE_HOME}
	cp -RL ${S}/dist/bin/* ${D}${MOZILLA_FIVE_HOME}

	# Create directory structure to support portage-installed extensions.
	# See update_chrome() in mozilla-launcher
	keepdir ${MOZILLA_FIVE_HOME}/chrome.d
	keepdir ${MOZILLA_FIVE_HOME}/extensions.d
	cp ${D}${MOZILLA_FIVE_HOME}/chrome/installed-chrome.txt \
		${D}${MOZILLA_FIVE_HOME}/chrome.d/0_base-chrome.txt || die "failed to copy"

	# Create /usr/bin/firefox
	install_mozilla_launcher_stub firefox ${MOZILLA_FIVE_HOME}

	# Install icon and .desktop for menu entry
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/icon/firefox-icon.png

	# Fix bug 54179: Install .desktop file into /usr/share/applications
	# instead of /usr/share/gnome/apps/Internet (18 Jun 2004 agriffis)
	insinto /usr/share/applications
	doins ${FILESDIR}/icon/mozillafirefox.desktop

	# Fix icons to look the same everywhere
	insinto ${MOZILLA_FIVE_HOME}/icons
	doins ${S}/build/package/rpm/SOURCES/mozicon16.xpm
	doins ${S}/build/package/rpm/SOURCES/mozicon50.xpm

	####################################
	#
	# Install files necessary for applications to build against firefox
	#
	####################################

	einfo "Installing includes and idl files..."
	dodir ${MOZILLA_FIVE_HOME}/include/idl /usr/include
	cd ${S}/dist
	cp -LfR include/* ${D}${MOZILLA_FIVE_HOME}/include || die "failed to copy"
	cp -LfR idl/* ${D}${MOZILLA_FIVE_HOME}/include/idl || die "failed to copy"

	# Install the NSS/SSL libs, headers and tools
	if use ssl; then
		einfo "Installing Mozilla-Firefox NSS..."
		# Install the headers ('make install' do not work for headers ...)
		insinto ${MOZILLA_FIVE_HOME}/include/nss
		[ -d ${S}/dist/public/nss ] && doins ${S}/dist/public/nss/*.h
		[ -d ${S}/dist/public/seccmd ] && doins ${S}/dist/public/seccmd/*.h
		[ -d ${S}/dist/public/security ] && doins ${S}/dist/public/security/*.h
		# These come with zlib ...
		rm -f ${D}${MOZILLA_FIVE_HOME}/include/nss/{zconf.h,zlib.h}

		cd ${S}/security/nss

		mkdir -p ${WORKDIR}/nss/{bin,lib}
		export SOURCE_BIN_DIR=${WORKDIR}/nss/bin
		export SOURCE_LIB_DIR=${WORKDIR}/nss/lib

		make install || die "make failed"
		# Gets installed as symbolic links ...
		# cp -Lf ${WORKDIR}/nss/bin/* ${D}/usr/bin
		cp -Lf ${WORKDIR}/nss/lib/* ${D}${MOZILLA_FIVE_HOME} || die "failed to copy"

		# Need to unset these incase we want to rebuild, else the build
		# gets newked.
		unset SOURCE_LIB_DIR
		unset SOURCE_BIN_DIR
	fi

	# Dirty hack to get some applications using this header running
	dosym ${MOZILLA_FIVE_HOME}/include/necko/nsIURI.h \
		/usr/$(get_libdir)/${MOZILLA_FIVE_HOME##*/}/include/nsIURI.h

	# Compatibility symlink so that applications can still build against firefox
	# even though it has moved.  To remove this symlink, grep -r MozillaFirefox
	# /usr/portage and fix those ebuilds
	dosym ${MOZILLA_FIVE_HOME##*/} ${MOZILLA_FIVE_HOME%/*}/MozillaFirefox

	# Fix firefox-config and install it
	sed -i -e "s|/usr/lib/firefox-${PV}|${MOZILLA_FIVE_HOME}|g
		s|/usr/include/firefox-${PV}|${MOZILLA_FIVE_HOME}/include|g
		s|\(echo -L.*\)\($\)|\1 -Wl,-R${MOZILLA_FIVE_HOME}\2|" \
		${S}/build/unix/firefox-config
	exeinto ${MOZILLA_FIVE_HOME}
	doexe ${S}/build/unix/firefox-config

	# Fix pkgconfig files and install them
	sed -i -e "s|-L/usr/lib/firefox-${PV}|-L\$\{libdir\}|" \
				${S}/build/unix/firefox-nspr.pc
	insinto /usr/$(get_libdir)/pkgconfig
	for x in ${S}/build/unix/*.pc; do
		sed -i -e "s|^libdir=.*|libdir=${MOZILLA_FIVE_HOME}|
			s|^includedir=.*|includedir=${MOZILLA_FIVE_HOME}/include|
			s|\(^Libs: -L.*\)\($\)|\1 -Wl,-R\$\{libdir\}\2|" ${x}
		doins ${x}
	done

	# Install docs
	dodoc LEGAL LICENSE
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
}

pkg_postrm() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	# Update the component registry
	MOZILLA_LIBDIR=${ROOT}${MOZILLA_FIVE_HOME} MOZILLA_LAUNCHER=firefox \
		/usr/libexec/mozilla-launcher -register

	update_mozilla_launcher_symlinks
}
