# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/mozilla-firebird/mozilla-firebird-0.6-r5.ebuild,v 1.4 2003/06/26 10:05:37 taviso Exp $

inherit makeedit flag-o-matic gcc nsplugins

# Added to get MozillaFirebird to compile on sparc.
replace-sparc64-flags

EMVER="0.65.2"
IPCVER="1.0.0.1"

S=${WORKDIR}/mozilla

DESCRIPTION="The Mozilla Firebird Web Browser"
HOMEPAGE="http://www.mozilla.org/projects/firebird/"
SRC_URI="http://komodo.mozilla.org/pub/firebird/releases/${PV}/MozillaFirebird-${PV}-source.tar.bz2"

KEYWORDS="x86 ~ppc sparc ~alpha"
SLOT="0"
LICENSE="MPL-1.1 | NPL-1.1"
IUSE="java gtk2 ipv6"

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
	!net-www/mozilla-firebird-bin"

DEPEND="${RDEPEND}
   virtual/glibc
   dev-lang/perl
   java? ( >=dev-java/java-config-0.2.0 )"
   
# needed by src_compile() and src_install()
export MOZ_PHOENIX=1
export MOZ_CALENDAR=0
export MOZ_ENABLE_XFT=1

src_unpack() {
	unpack MozillaFirebird-${PV}-source.tar.bz2
	
	# alpha stubs patch from lfs project.
	# <taviso@gentoo.org> (26 Jun 2003)
	use alpha && epatch ${FILESDIR}/mozilla-1.3-alpha-stubs.patch
}

src_compile() {
   local myconf="--disable-composer \
      --with-x \
      --with-system-jpeg \
      --with-system-zlib \
      --with-system-png \
      --with-system-mng \
      --disable-mailnews \
      --disable-calendar \
      --enable-xft \
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
      --with-default-mozilla-five-home=/usr/lib/MozillaFirebird \
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
	  --enable-optimize=-O2 \
      --disable-ldap \
      --disable-toolkit-qt \
      --disable-toolkit-xlib"

    if [ -n "`use gtk2`" ] ; then
        myconf="${myconf} --enable-toolkit-gtk2 \
                          --enable-default-toolkit=gtk2 \
                          --disable-toolkit-gtk"
    else
        myconf="${myconf} --enable-toolkit-gtk \
                          --enable-default-toolkit=gtk \
                          --disable-toolkit-gtk2"
    fi

    if [ -n "`use ipv6`" ] ; then
        myconf="${myconf} --enable-ipv6"
    fi

   # Crashes on start when compiled with -fomit-frame-pointer
   filter-flags -fomit-frame-pointer
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

   econf ${myconf} || die

   edit_makefiles
   emake MOZ_PHOENIX=1 || die
}

src_install() {
   # Plugin path creation
   PLUGIN_DIR="/usr/lib/nsbrowser/plugins"
   dodir ${PLUGIN_DIR}

   dodir /usr/lib
   dodir /usr/lib/MozillaFirebird
   cp -RL --no-preserve=links ${S}/dist/bin/* ${D}/usr/lib/MozillaFirebird

   #fix permissions
   chown -R root.root ${D}/usr/lib/MozillaFirebird
   
   # Plugin path setup (rescuing the existent plugins)
   src_mv_plugins /usr/lib/MozillaFirebird/plugins

   dobin ${FILESDIR}/MozillaFirebird

	# Fix icons to look the same everywhere
	insinto /usr/lib/MozillaFirebird/icons
	doins ${S}/build/package/rpm/SOURCES/mozicon16.xpm
	doins ${S}/build/package/rpm/SOURCES/mozicon50.xpm

	# Install icon and .desktop for menu entry
	if [ "`use gnome`" ]
	then
		insinto /usr/share/pixmaps
		doins ${S}/build/package/rpm/SOURCES/mozilla-icon.png

		# Fix comment of menu entry
		cd ${S}/build/package/rpm/SOURCES
		perl -pi -e 's:Name=Mozilla:Name=Mozilla Firebird:' mozilla.desktop
		perl -pi -e 's:Comment=Mozilla:Comment=Mozilla Firebird Web Browser:' mozilla.desktop
		cd ${S}
		insinto /usr/share/gnome/apps/Internet
		doins ${S}/build/package/rpm/SOURCES/mozilla.desktop
	fi
}

pkg_preinst() {
   # Remove the old plugins dir
   pkg_mv_plugins /usr/lib/MozillaFirebird/plugins
}
