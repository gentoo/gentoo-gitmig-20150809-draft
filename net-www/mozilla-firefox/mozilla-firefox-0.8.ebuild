# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mozilla-firefox/mozilla-firefox-0.8.ebuild,v 1.5 2004/02/12 16:24:20 bazik Exp $

inherit makeedit flag-o-matic gcc nsplugins eutils

S=${WORKDIR}/mozilla

DESCRIPTION="The Mozilla Firefox Web Browser"
HOMEPAGE="http://www.mozilla.org/projects/firefox/"
SRC_URI="http://ftp.mozilla.org/pub/firefox/releases/${PV}/firefox-source-${PV}.tar.bz2"

KEYWORDS="x86 ~ppc sparc ~alpha ~amd64 ~ia64"
SLOT="0"
LICENSE="MPL-1.1 | NPL-1.1"
IUSE="java gtk2 ipv6 gnome moznoxft"

RDEPEND="virtual/x11
	>=dev-libs/libIDL-0.8.0
	>=gnome-base/ORBit-0.5.10-r1
	virtual/xft
	>=sys-libs/zlib-1.1.4
	>=media-libs/jpeg-6b
	>=media-libs/libmng-1.0.0
	>=media-libs/libpng-1.2.1
	>=sys-apps/portage-2.0.36
	dev-libs/expat
	app-arch/zip
	app-arch/unzip
	( gtk2? >=x11-libs/gtk+-2.1.1 :
		=x11-libs/gtk+-1.2* )
	java?  ( virtual/jre )
	!net-www/mozilla-firefox-bin"

DEPEND="${RDEPEND}
	virtual/glibc
	dev-lang/perl
	java? ( >=dev-java/java-config-0.2.0 )"

# needed by src_compile() and src_install()
export MOZ_PHOENIX=1
export MOZ_CALENDAR=0
export MOZ_ENABLE_XFT=1

src_unpack() {
	unpack firefox-source-${PV}.tar.bz2

	# alpha stubs patch from lfs project.
	# <taviso@gentoo.org> (26 Jun 2003)
	use alpha && epatch ${FILESDIR}/mozilla-1.3-alpha-stubs.patch
	use amd64 && epatch ${FILESDIR}/mozilla-firebird-amd64.patch

}

src_compile() {
	local enable_optimize=''
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
		--enable-crypto \
		--enable-xinerama=no \
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
		--enable-extensions=default,-inspector,-irc,-venkman,-content-packs,-help"

	if [ -n "`use gtk2`" ] ; then
		myconf="${myconf} --enable-toolkit-gtk2 \
							--enable-default-toolkit=gtk2 \
							--disable-toolkit-gtk"
	else
		myconf="${myconf} --enable-toolkit-gtk \
							--enable-default-toolkit=gtk \
							--disable-toolkit-gtk2"
	fi

	if [ -z "`use moznoxft`" ]
	then
		if [ -n "`use gtk2`" ]
		then
			local pango_version=""

			# We need Xft2.0 localy installed
			if (test -x /usr/bin/pkg-config) && (pkg-config xft)
			then
				pango_version="`pkg-config --modversion pango | cut -d. -f1,2`"
				pango_version="`echo ${pango_version} | sed -e 's:\.::g'`"

				# We also need pango-1.1, else Mozilla links to both
				# Xft1.1 *and* Xft2.0, and segfault...
				if [ "${pango_version}" -gt "10" ]
				then
					einfo "Building with Xft2.0 (Gtk+-2.0) support!"
					myconf="${myconf} --enable-xft --disable-freetype2"
					touch ${WORKDIR}/.xft
				else
					ewarn "Building without Xft2.0 support!"
					myconf="${myconf} --disable-xft `use_enable truetype freetype2`"
				fi
			else
				ewarn "Building without Xft2.0 support!"
				myconf="${myconf} --disable-xft `use_enable truetype freetype2`"
			fi
		else
			einfo "Building with Xft2.0 (Gtk+-1.0) support!"
			myconf="${myconf} --enable-xft --disable-freetype2"
			touch ${WORKDIR}/.xft
		fi
	else
		myconf="${myconf} --disable-xft `use_enable truetype freetype2`"
	fi

	if [ -n "`use ipv6`" ] ; then
		myconf="${myconf} --enable-ipv6"
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
			if [ "$(gcc-major-version).$(gcc-minor-version)" = "3.3" ]; then
				append-flags -fno-strict-aliasing
			fi
			;;
	esac

	# 32-bit vs. 64-bit optimization
	case "${ARCH}" in
		alpha|amd64|ia64)
			# Allow -O0 or -O1: Anything more than this causes
			# segfaults on startup on 64-bit (bug 33767)
			enable_optimize=$(echo "$CFLAGS" | sed 's/.*\(-O[01]\?\).*/\1/p')
			enable_optimize=${enable_optimize:--O1}
			filter-flags -O -O?
			;;
		*)
			# -O2 and below allowed on 32-bit
			enable_optimize=$(echo "$CFLAGS" | sed 's/.*\(-O[012]\?\).*/\1/p')
			enable_optimize=${enable_optimize:--O2}
			filter-flags -O -O?
			;;
	esac

	# Crashes on start when compiled with -fomit-frame-pointer
	filter-flags -fomit-frame-pointer -mpowerpc-gfxopt
	filter-flags -ffast-math
	append-flags -s -fforce-addr

	if [ "$(gcc-major-version)" -eq "3" ]; then
		# Currently gcc-3.2 or older do not work well if we specify "-march"
		# and other optimizations for pentium4.
		if [ "$(gcc-minor-version)" -lt "3" ]; then
			replace-flags -march=pentium4 -march=pentium3
			filter-flags -msse2
		fi

		# Enable us to use flash, etc plugins compiled with gcc-2.95.3
		if [ "${ARCH}" = "x86" ]; then
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

	dobin ${FILESDIR}/firefox
	insinto /etc/env.d
	doins ${FILESDIR}/10MozillaFirefox

	# Fix icons to look the same everywhere
	insinto /usr/lib/MozillaFirefox/icons
	doins ${S}/build/package/rpm/SOURCES/mozicon16.xpm
	doins ${S}/build/package/rpm/SOURCES/mozicon50.xpm

	# Install icon and .desktop for menu entry
	if [ "`use gnome`" ]
	then
		insinto /usr/share/pixmaps
		doins ${S}/build/package/rpm/SOURCES/mozilla-icon.png

		# Fix comment of menu entry
		cd ${S}/build/package/rpm/SOURCES
		cp mozilla.desktop mozillafirefox.desktop
		perl -pi -e 's:Name=Mozilla:Name=Mozilla Firefox:' mozillafirefox.desktop
		perl -pi -e 's:Comment=Mozilla:Comment=Mozilla Firefox Web Browser:' mozillafirefox.desktop
		perl -pi -e 's:Exec=/usr/bin/mozilla:Exec=/usr/bin/firefox:' mozillafirefox.desktop
		cd ${S}
		insinto /usr/share/gnome/apps/Internet
		doins ${S}/build/package/rpm/SOURCES/mozillafirefox.desktop
	fi
}

pkg_preinst() {
	# Remove the old plugins dir
	pkg_mv_plugins /usr/lib/MozillaFirefox/plugins
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

}
