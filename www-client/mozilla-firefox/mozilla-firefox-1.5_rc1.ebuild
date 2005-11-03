# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/mozilla-firefox/mozilla-firefox-1.5_rc1.ebuild,v 1.2 2005/11/03 16:13:29 anarchy Exp $

unset ALLOWED_FLAGS  # stupid extra-functions.sh ... bug 49179
MOZ_FREETYPE2="no"   # Need to disable for newer .. remove here and in mozconfig
	                 # when older is removed from tree.
MOZ_PANGO="yes"      # Need to enable for newer .. remove here and in mozconfig
	                 # when older is removed from tree.

inherit flag-o-matic toolchain-funcs eutils mozconfig mozilla-launcher makeedit multilib fdo-mime versionator

MY_P="$(replace_version_separator 2 '')"
FV=${MY_P/beta/b}

DESCRIPTION="Firefox Web Browser"
HOMEPAGE="http://www.mozilla.org/projects/firefox/"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${FV}/source/firefox-${FV}-source.tar.bz2
	mirror://gentoo/mozilla-jslibmath-alpha.patch
	mirror://gentoo/embed-typeaheadfind.patch"

KEYWORDS="-*"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"
IUSE="java mozdevelop"

RDEPEND="java? ( virtual/jre )
	>=www-client/mozilla-launcher-1.39
	=x11-libs/pango-1.10.1"

DEPEND="${RDEPEND}
	java? ( >=dev-java/java-config-0.2.0 )"

S=${WORKDIR}/mozilla

# Needed by src_compile() and src_install().
# Would do in pkg_setup but that loses the export attribute, they
# become pure shell variables.
export MOZ_CO_PROJECT=browser
export BUILD_OFFICIAL=1
export MOZILLA_OFFICIAL=1

src_unpack() {
	unpack firefox-${FV}-source.tar.bz2
	cd ${S} || die "cd failed"

	####################################
	#
	# architecture patches
	#
	####################################

	# alpha stubs patch from lfs project.
	# <taviso@gentoo.org> (26 Jun 2003)
	use alpha && epatch ${FILESDIR}/1.5/mozilla-1.3-alpha-stubs.patch

	# amd64 visibility patch
	if [[ ${ARCH} == amd64 ]] && [[ $(gcc-major-version) -ge 3 ]]; then
	    epatch ${FILESDIR}/1.5/firefox-visibility.patch
	fi

	# hppa patches from Ivar <orskaug@stud.ntnu.no>
	# <gmsoft@gentoo.org> (22 Dec 2004)
	epatch ${FILESDIR}/1.5/mozilla-hppa.patch

	# patch to solve segfaults on ia64, from Debian, originally from David
	# Mosberger
	epatch ${FILESDIR}/1.5/mozilla-firefox-1.1a2-ia64.patch

	# patch to fix math operations on alpha, makes maps.google.com work!
	epatch ${DISTDIR}/mozilla-jslibmath-alpha.patch

	####################################
	#
	# general compilation and run-time fixes
	#
	####################################

	# patch from fedora to remove the pangoxft things
	epatch ${FILESDIR}/1.5/firefox-nopangoxft.patch
	#cairo-canvas patch
	epatch ${FILESDIR}/1.5/firefox-cairo-canvas.patch

	####################################
	#
	# behavioral fixes
	#
	####################################

	# patch to fix typeahead find for browsers which embed Firefox
	# http://bugzilla.gnome.org/show_bug.cgi?id=157435
	epatch ${DISTDIR}/embed-typeaheadfind.patch

	# Fix scripts that call for /usr/local/bin/perl #51916
	ebegin "Patching smime to call perl from /usr/bin"
	sed -i -e '1s,usr/local/bin,usr/bin,' ${S}/security/nss/cmd/smimetools/smime
	eend $? || die "sed failed"

	ewarn ""
	ewarn ""
	ewarn "This firefox-1.5rc1 ebuild is provided for your convenience,"
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

	mozconfig_annotate '' --enable-extensions=default,typeaheadfind
	mozconfig_annotate '' --disable-mailnews
	#mozconfig_annotate '' --enable-native-uconv
	mozconfig_annotate '' --enable-image-encoder=all

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
	cp -RL ${S}/dist/bin/* ${D}${MOZILLA_FIVE_HOME}

	# Create directory structure to support portage-installed extensions.
	# See update_chrome() in mozilla-launcher
	keepdir ${MOZILLA_FIVE_HOME}/chrome.d
	keepdir ${MOZILLA_FIVE_HOME}/extensions.d
	cp ${D}${MOZILLA_FIVE_HOME}/chrome/installed-chrome.txt \
		${D}${MOZILLA_FIVE_HOME}/chrome.d/0_base-chrome.txt

	# Create /usr/bin/firefox
	install_mozilla_launcher_stub firefox ${MOZILLA_FIVE_HOME}

	# Install icon and .desktop for menu entry
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/icon/firefox-icon.png

	# Fix bug 54179: Install .desktop file into /usr/share/applications
	# instead of /usr/share/gnome/apps/Internet (18 Jun 2004 agriffis)
	insinto /usr/share/applications
	doins ${FILESDIR}/icon/mozillafirefox.desktop

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

	# Fix firefox-config and install it
	sed -i -e "s|/usr/lib/firefox-${MY_PV}|${MOZILLA_FIVE_HOME}|g
		s|/usr/include/firefox-${MY_PV}|${MOZILLA_FIVE_HOME}/include|g
		s|/usr/share/idl/firefox-${MY_PV}|${MOZILLA_FIVE_HOME}/idl|g
		s|\(echo -L.*\)\($\)|\1 -Wl,-R${MOZILLA_FIVE_HOME}\2|" \
		${S}/build/unix/firefox-config
	exeinto ${MOZILLA_FIVE_HOME}
	doexe ${S}/build/unix/firefox-config

	# Fix pkgconfig files and install them
	sed -i -e "s|-L/usr/lib/firefox-${MY_PV}|-L\$\{libdir\}|
			s|-I/usr/include/firefox-${MY_PV}|-I\$\{includedir\}|" \
				${S}/build/unix/firefox-nspr.pc
	insinto /usr/$(get_libdir)/pkgconfig
	for x in ${S}/build/unix/*.pc; do
		sed -i -e "s|^libdir=.*|libdir=${MOZILLA_FIVE_HOME}|
			s|^includedir=.*|includedir=${MOZILLA_FIVE_HOME}/include|
			s|^idldir=.*|idldir=${MOZILLA_FIVE_HOME}/idl|
			s|\(^Libs: -L.*\)\($\)|\1 -Wl,-R\$\{libdir\}\2|" ${x}
		doins ${x}
	done

	####################################
	# 
	# Some preferences, probably gentoo.org as start-page also
	#
	####################################

	dodir ${D}/${MOZILLA_FIVE_HOME}/greprefs
	cp ${FILESDIR}/gentoo-default-prefs.js ${D}/${MOZILLA_FIVE_HOME}/greprefs/all-gentoo.js
	dodir ${D}/${MOZILLA_FIVE_HOME}/defaults/pref
	cp ${FILESDIR}/gentoo-default-prefs.js ${D}/${MOZILLA_FIVE_HOME}/defaults/pref/all-gentoo.js

	# Install docs
	dodoc LEGAL LICENSE
}

pkg_postinst() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	####################################
	#
	# The registration is done here,
	# mozilla-launcher do not do it correctly for now
	#
	####################################

	touch ${MOZILLA_FIVE_HOME}/components/compreg.dat
	touch ${MOZILLA_FIVE_HOME}/components/xpti.dat
	[ -x ${MOZILLA_FIVE_HOME}/firefox ] && ${MOZILLA_FIVE_HOME}/firefox -register
	[ -x ${MOZILLA_FIVE_HOME}/regxpcom ] && ${MOZILLA_FIVE_HOME}/regxpcom

	# This should be called in the postinst and postrm of all the
	# mozilla, mozilla-bin, firefox, firefox-bin, thunderbird and
	# thunderbird-bin ebuilds.
	update_mozilla_launcher_symlinks

	ewarn ""
	ewarn ""
	ewarn "This firefox-1.5rc1 ebuild is provided for your convenience,"
	ewarn "the use of this ebuild is not supported by gentoo developers. "
	ewarn "Please file bugs related to firefox-1.5 with upstream developers."
	ewarn "Bugs should be filed @ https://bugzilla.mozilla.org."
	ewarn "Thank you Anarchy"
}

pkg_postrm() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	####################################
	#
	# The registration is done here,
	# mozilla-launcher do not do it correctly for now
	#
	####################################

	[ -x ${MOZILLA_FIVE_HOME}/firefox ] && ${MOZILLA_FIVE_HOME}/firefox -register
	[ -x ${MOZILLA_FIVE_HOME}/regxpcom ] && ${MOZILLA_FIVE_HOME}/regxpcom
	update_mozilla_launcher_symlinks
}
