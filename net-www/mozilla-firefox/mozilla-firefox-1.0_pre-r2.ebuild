# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mozilla-firefox/mozilla-firefox-1.0_pre-r2.ebuild,v 1.9 2004/11/08 15:08:52 vapier Exp $

inherit makeedit flag-o-matic gcc nsplugins eutils mozilla mozilla-launcher

S=${WORKDIR}/mozilla

DESCRIPTION="The Mozilla Firefox Web Browser"
HOMEPAGE="http://www.mozilla.org/projects/firefox/"
MY_PV=${PV/_pre/PR.1}
SRC_URI="mirror://gentoo/firefox-${MY_PV}-source.tar.bz2 \
	http://dev.gentoo.org/~brad/firefox-${MY_PV}-source.tar.bz2"

LICENSE="MPL-1.1 NPL-1.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm ia64 ppc sparc x86"
IUSE="java gtk2 ipv6 moznoxft truetype xinerama"

RDEPEND="virtual/x11
	!moznoxft? ( virtual/xft )
	>=sys-libs/zlib-1.1.4
	>=media-libs/jpeg-6b
	>=media-libs/libmng-1.0.0
	>=media-libs/libpng-1.2.1
	>=sys-apps/portage-2.0.36
	dev-libs/expat
	app-arch/zip
	app-arch/unzip
	gtk2?  ( >=x11-libs/gtk+-2.1.1 >=dev-libs/libIDL-0.8.0 )
	!gtk2? ( =x11-libs/gtk+-1.2* =gnome-base/orbit-0* )
	java?  ( virtual/jre )
	>=net-www/mozilla-launcher-1.20"

DEPEND="${RDEPEND}
	virtual/libc
	dev-util/pkgconfig
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
}

src_compile() {
	local myconf

	####################################
	#
	# myconf, CFLAGS and CXXFLAGS setup
	#
	####################################

	# mozilla_conf comes from mozilla.eclass
	mozilla_conf

	# 1.0PR requires --enable-single-profile to build
	# http://bugzilla.mozilla.org/show_bug.cgi?id=258831
	myconf="${myconf} \
		--with-default-mozilla-five-home=/usr/lib/MozillaFirefox \
		--enable-single-profile"

	# hardened GCC uses -fstack-protector-all by default, and this breaks
	# firefox.
	has_hardened && append-flags -fno-stack-protector-all
	replace-flags -fstack-protector-all -fstack-protector

	####################################
	#
	#  Configure and build Firefox
	#
	####################################

	econf ${myconf} || die

	# This removes extraneous CFLAGS from the Makefiles to reduce RAM
	# requirements while compiling
	edit_makefiles

	emake MOZ_PHOENIX=1 || die
}

src_install() {
	# Plugin path creation
	PLUGIN_DIR="/usr/lib/nsbrowser/plugins"
	dodir ${PLUGIN_DIR}

	dodir /usr/lib
	dodir /usr/lib/MozillaFirefox
	cp -RL --no-preserve=links ${S}/dist/bin/* ${D}/usr/lib/MozillaFirefox

	#fix permissions
	chown -R root:root ${D}/usr/lib/MozillaFirefox

	# Plugin path setup (rescuing the existent plugins)
	src_mv_plugins /usr/lib/MozillaFirefox/plugins

	dodir /usr/bin
	dosym /usr/libexec/mozilla-launcher /usr/bin/firefox
	insinto /etc/env.d
	doins ${FILESDIR}/10MozillaFirefox

	# Fix icons to look the same everywhere
	insinto /usr/lib/MozillaFirefox/icons
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
	tar xjpf ${FILESDIR}/firefox-0.9-init.tar.bz2 -C ${D}/usr/lib/MozillaFirefox
}

pkg_preinst() {
	export MOZILLA_FIVE_HOME=${ROOT}/usr/lib/MozillaFirefox

	# Remove the old plugins dir
	pkg_mv_plugins /usr/lib/MozillaFirefox/plugins

	# Remove entire installed instance to prevent all kinds of
	# problems... see bug 44772 for example
	rm -rf "${MOZILLA_FIVE_HOME}"
}

pkg_postinst() {
	export MOZILLA_FIVE_HOME="${ROOT}/usr/lib/MozillaFirefox"

	# Needed to update the run time bindings for REGXPCOM
	# (do not remove next line!)
	env-update

	# Register Components and Chrome
	einfo "Registering Components and Chrome..."
	LD_LIBRARY_PATH=/usr/lib/MozillaFirefox ${MOZILLA_FIVE_HOME}/regxpcom
	LD_LIBRARY_PATH=/usr/lib/MozillaFirefox ${MOZILLA_FIVE_HOME}/regchrome

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
