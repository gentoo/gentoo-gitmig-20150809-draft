# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/mozilla-firefox/mozilla-firefox-0.9.3.ebuild,v 1.1 2005/03/18 19:47:25 seemant Exp $

inherit makeedit flag-o-matic gcc nsplugins eutils mozilla-launcher

S=${WORKDIR}/mozilla

DESCRIPTION="The Mozilla Firefox Web Browser"
HOMEPAGE="http://www.mozilla.org/projects/firefox/"
# Mirrors have it in one of the following places, depending on what
# mirror you check and when you check it... :-(
SRC_URI="
	http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${PV}/firefox-${PV}-source.tar.bz2
	http://ftp.mozilla.org/pub/firefox/releases/${PV}/firefox-${PV}-source.tar.bz2"

KEYWORDS="x86 ppc sparc alpha amd64 ia64"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"
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
	>=net-www/mozilla-launcher-1.7-r1"

DEPEND="${RDEPEND}
	virtual/libc
	dev-util/pkgconfig
	java? ( >=dev-java/java-config-0.2.0 )"

# needed by src_compile() and src_install()
export MOZ_PHOENIX=1
export MOZ_CALENDAR=0
export MOZ_ENABLE_XFT=1

src_unpack() {
	unpack firefox-${PV}-source.tar.bz2 || die "unpack failed"
	cd ${S} || die "cd failed"

	# alpha stubs patch from lfs project.
	# <taviso@gentoo.org> (26 Jun 2003)
	use alpha && epatch ${FILESDIR}/mozilla-1.3-alpha-stubs.patch

	# this patch fixes upstream bug 248442 "Crash in form autocomplete
	# (64-bit arch only)".
	epatch ${FILESDIR}/firefox-0.9-nsFormHistory-crash-fix.patch
}

src_compile() {
	local enable_optimize
	local myconf="--disable-composer \
		--with-x \
		--with-system-jpeg \
		--with-system-zlib \
		--with-system-png \
		--with-system-mng \
		--disable-mailnews \
		--disable-calendar \
		--disable-pedantic \
		--disable-svg \
		--enable-mathml \
		--without-system-nspr \
		--enable-nspr-autoconf \
		--enable-xsl \
		$(use_enable ipv6) \
		--enable-crypto \
		--with-java-supplement \
		--with-pthreads \
		--with-default-mozilla-five-home=/usr/lib/MozillaFirefox \
		--with-user-appdir=.phoenix \
		--disable-jsd \
		--disable-accessibility \
		--disable-tests \
		--disable-debug \
		--disable-dtd-debug \
		--disable-logging \
		--enable-reorder \
		--enable-strip \
		--enable-strip-libs \
		--enable-cpp-rtti \
		--enable-xterm-updates \
		--disable-ldap \
		--disable-toolkit-qt \
		--disable-toolkit-xlib \
		--enable-extensions=default,-irc,-venkman,-content-packs,-help"

	if use gtk2; then
		myconf="${myconf} \
			--enable-toolkit-gtk2 \
			--enable-default-toolkit=gtk2 \
			--disable-toolkit-gtk"
	else
		myconf="${myconf} \
			--enable-toolkit-gtk \
			--enable-default-toolkit=gtk \
			--disable-toolkit-gtk2"
	fi

	if use moznoxft; then
		myconf="${myconf} --disable-xft $(use_enable truetype freetype2)"
	elif use gtk2; then
		local pango_version

		# We need Xft2.0 localy installed
		if [[ -x /usr/bin/pkg-config ]] && pkg-config xft; then
			pango_version="$(pkg-config --modversion pango | cut -d. -f1,2)"

			# We also need pango-1.1, else Mozilla links to both
			# Xft1.1 *and* Xft2.0, and segfault...
			if [[ ${pango_version//.} -gt 10 ]]; then
				einfo "Building with Xft2.0 (Gtk+-2.0) support!"
				myconf="${myconf} --enable-xft --disable-freetype2"
				touch ${WORKDIR}/.xft
			else
				ewarn "Building without Xft2.0 support!"
				myconf="${myconf} --disable-xft $(use_enable truetype freetype2)"
			fi
		else
			ewarn "Building without Xft2.0 support!"
			myconf="${myconf} --disable-xft $(use_enable truetype freetype2)"
		fi
	else
		einfo "Building with Xft2.0 (Gtk+-1.0) support!"
		myconf="${myconf} --enable-xft --disable-freetype2"
		touch ${WORKDIR}/.xft
	fi

	# Check for xinerama - closes #19369
	if use xinerama; then
		myconf="${myconf} --enable-xinerama=yes"
	else
		myconf="${myconf} --enable-xinerama=no"
	fi

	# Per-architecture flags
	case "${ARCH}" in
		alpha|amd64|ia64)
			# 64-bit needs -fPIC
			append-flags -fPIC
			;;
		sparc)
			# Added to get MozillaFirebird to compile on sparc
			replace-sparc64-flags
			;;
		ppc)
			# Fix to avoid gcc-3.3.x miscompilation issues.
			if [[ "$(gcc-major-version).$(gcc-minor-version)" == 3.3 ]]; then
				append-flags -fno-strict-aliasing
			fi
			;;
	esac

	# 32-bit vs. 64-bit optimization
	case "${ARCH}" in
		alpha|amd64|ia64)
			# Allow -O0 or -O1: Anything more than this causes
			# segfaults on startup on 64-bit (bug 33767)
			enable_optimize=$(echo "$CFLAGS" | grep -Eoe '-O[01]|-O\>')
			enable_optimize=${enable_optimize:--O1}
			filter-flags -O -O?
			;;
		*)
			# -O2 and below allowed on 32-bit
			enable_optimize=$(echo "$CFLAGS" | grep -Eoe '-O[012]|-O\>')
			enable_optimize=${enable_optimize:--O2}
			filter-flags -O -O?
			;;
	esac

	# Crashes on start when compiled with -fomit-frame-pointer
	filter-flags -fno-default-inline	# see bug 42488
	filter-flags -fstack-protector		# see bug 45671
	filter-flags -fomit-frame-pointer -mpowerpc-gfxopt
	filter-flags -ffast-math
	append-flags -s -fforce-addr

	if [[ $(gcc-major-version) -eq 3 ]]; then
		# gcc-3 prior to 3.2.3 doesn't work well for pentium4
		if [[ $(gcc-minor-version) -lt 2 ||
			( $(gcc-minor-version) -eq 2 && $(gcc-micro-version) -lt 3 ) ]]
		then
			replace-flags -march=pentium4 -march=pentium3
			filter-flags -msse2
		fi

		# Enable us to use flash, etc plugins compiled with gcc-2.95.3
		if [[ ${ARCH} == x86 ]]; then
			myconf="${myconf} --enable-old-abi-compat-wrappers"
		fi
	fi

	econf --enable-optimize="${enable_optimize}" ${myconf} || die

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
