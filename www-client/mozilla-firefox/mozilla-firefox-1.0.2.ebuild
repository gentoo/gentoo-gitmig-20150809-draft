# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/mozilla-firefox/mozilla-firefox-1.0.2.ebuild,v 1.2 2005/03/23 20:05:30 seemant Exp $

inherit makeedit flag-o-matic gcc nsplugins eutils mozconfig mozilla-launcher multilib

S=${WORKDIR}/mozilla

DESCRIPTION="The Mozilla Firefox Web Browser"
HOMEPAGE="http://www.mozilla.org/projects/firefox/"
MY_PV=${PV/_rc/rc}
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${MY_PV}/source/firefox-${MY_PV}-source.tar.bz2"

LICENSE="MPL-1.1 NPL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~sparc x86"
IUSE="java mozsvg"

# xrender.pc appeared for the first time in xorg-x11-6.7.0-r2
# and is required to build with support for cairo.  #71504
RDEPEND="java? ( virtual/jre )
	>=media-libs/libmng-1.0.0
	mozsvg? (
		>=x11-base/xorg-x11-6.7.0-r2
		x11-libs/cairo
	)
	>=www-client/mozilla-launcher-1.28"

DEPEND="${RDEPEND}
	java? ( >=dev-java/java-config-0.2.0 )"

# Needed by src_compile() and src_install().
# Would do in pkg_setup but that loses the export attribute, they
# become pure shell variables.
export MOZ_PHOENIX=1

src_unpack() {
	unpack firefox-${MY_PV}-source.tar.bz2 || die "unpack failed"
	cd ${S} || die "cd failed"

	# alpha stubs patch from lfs project.
	# <taviso@gentoo.org> (26 Jun 2003)
	use alpha && epatch ${FILESDIR}/mozilla-1.3-alpha-stubs.patch

	# hppa patches from Ivar <orskaug@stud.ntnu.no>
	# <gmsoft@gentoo.org> (22 Dec 2004)
	epatch ${FILESDIR}/mozilla-hppa.patch

	# patch out ft caching code since the API changed between releases of
	# freetype; this enables freetype-2.1.8+ compat.
	# https://bugzilla.mozilla.org/show_bug.cgi?id=234035#c65
	epatch ${FILESDIR}/mozilla-firefox-1.0-4ft2.patch

	# patch to fix separate character on euro keyboards, bug 68995
	epatch ${FILESDIR}/mozilla-firefox-1.0-kp_separator.patch

	if has_version '>=x11-libs/cairo-0.3.0'; then
		epatch ${FILESDIR}/svg-cairo-0.3.0-fix.patch
	fi
}

src_compile() {
	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	mozconfig_init

	# Bug 60668: Galeon doesn't build without oji enabled, so enable it
	# regardless of java setting.
	mozconfig_annotate '' --enable-oji --enable-mathml

	# Other ff-specific settings
	mozconfig_use_enable mozdevelop jsd
	mozconfig_use_enable mozdevelop xpctools
	mozconfig_use_extension mozdevelop venkman
	mozconfig_use_enable gnome gnomevfs
	mozconfig_use_extension gnome gnomevfs
	mozconfig_use_enable mozsvg svg
	mozconfig_use_enable mozsvg svg-renderer-cairo
	mozconfig_annotate '' --with-default-mozilla-five-home=/usr/$(get_libdir)/MozillaFirefox

	# Finalize and report settings
	mozconfig_final

	# hardened GCC uses -fstack-protector-all by default, and this breaks
	# firefox.
	has_hardened && append-flags -fno-stack-protector-all
	replace-flags -fstack-protector-all -fstack-protector

	####################################
	#
	#  Configure and build Firefox
	#
	####################################

	# ./configure picks up the mozconfig stuff
	export LD="$(tc-getLD)"
	export CC="$(tc-getCC)"
	export CXX="$(tc-getCXX)"
	econf

	# This removes extraneous CFLAGS from the Makefiles to reduce RAM
	# requirements while compiling
	edit_makefiles

	emake MOZ_PHOENIX=1 CXX="$(tc-getCXX)" CC="$(tc-getCC)" LD="$(tc-getLD)" || die
}

src_install() {
	# Plugin path creation
	PLUGIN_DIR="/usr/$(get_libdir)/nsbrowser/plugins"
	dodir ${PLUGIN_DIR}

	dodir /usr/$(get_libdir)/MozillaFirefox
	cp -RL --no-preserve=links ${S}/dist/bin/* ${D}/usr/$(get_libdir)/MozillaFirefox

	#fix permissions
	chown -R root:root ${D}/usr/$(get_libdir)/MozillaFirefox

	# Plugin path setup (rescuing the existent plugins)
	src_mv_plugins /usr/$(get_libdir)/MozillaFirefox/plugins

	dodir /usr/bin
	cat <<EOF >${D}/usr/bin/firefox
#!/bin/sh
# 
# Stub script to run mozilla-launcher.  We used to use a symlink here but
# OOo brokenness makes it necessary to use a stub instead:
# http://bugs.gentoo.org/show_bug.cgi?id=78890

export MOZILLA_LAUNCHER=firefox
exec /usr/libexec/mozilla-launcher "\$@"
EOF
chmod 0755 ${D}/usr/bin/firefox
	insinto /etc/env.d
	doins ${FILESDIR}/10MozillaFirefox

	# Fix icons to look the same everywhere
	insinto /usr/$(get_libdir)/MozillaFirefox/icons
	doins ${S}/build/package/rpm/SOURCES/mozicon16.xpm
	doins ${S}/build/package/rpm/SOURCES/mozicon50.xpm

	# Install icon and .desktop for menu entry
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/icon/firefox-icon.png
	# Fix bug 54179: Install .desktop file into /usr/share/applications
	# instead of /usr/share/gnome/apps/Internet (18 Jun 2004 agriffis)
	insinto /usr/share/applications
	doins ${FILESDIR}/icon/mozillafirefox.desktop

	# Normally firefox-0.9 must be run as root once before it can be
	# run as a normal user.  Drop in some initialized files to avoid
	# this.
	einfo "Extracting firefox-${PV} initialization files"
	tar xjpf ${FILESDIR}/firefox-0.9-init.tar.bz2 -C ${D}/usr/$(get_libdir)/MozillaFirefox
}

pkg_preinst() {
	export MOZILLA_FIVE_HOME=${ROOT}/usr/$(get_libdir)/MozillaFirefox

	# Remove the old plugins dir
	pkg_mv_plugins /usr/$(get_libdir)/MozillaFirefox/plugins

	# Remove entire installed instance to prevent all kinds of
	# problems... see bug 44772 for example
	rm -rf "${MOZILLA_FIVE_HOME}"
}

pkg_postinst() {
	export MOZILLA_FIVE_HOME="${ROOT}/usr/$(get_libdir)/MozillaFirefox"

	# Needed to update the run time bindings for REGXPCOM
	# (do not remove next line!)
	env-update

	# Register Components and Chrome
	#
	# Bug 67031: Set HOME=~root in case this is being emerged via sudo.
	# Otherwise the following commands will create ~/.mozilla owned by root
	# and 700 perms, which makes subsequent execution of firefox by user
	# impossible.
	einfo "Registering Components and Chrome..."
	HOME=~root LD_LIBRARY_PATH=/usr/$(get_libdir)/MozillaFirefox ${MOZILLA_FIVE_HOME}/regxpcom
	HOME=~root LD_LIBRARY_PATH=/usr/$(get_libdir)/MozillaFirefox ${MOZILLA_FIVE_HOME}/regchrome

	# Fix permissions of component registry
	chmod 0644 ${MOZILLA_FIVE_HOME}/components/compreg.dat

	# Fix directory permissions
	find ${MOZILLA_FIVE_HOME}/ -type d -perm 0700 -exec chmod 0755 {} \; || :

	# Fix permissions on chrome files
	find ${MOZILLA_FIVE_HOME}/chrome/ -name '*.rdf' -exec chmod 0644 {} \; || :

	# This should be called in the postinst and postrm of all the
	# mozilla, mozilla-bin, firefox, firefox-bin, thunderbird and
	# thunderbird-bin ebuilds.
	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	update_mozilla_launcher_symlinks
}
