# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mozilla-thunderbird/mozilla-thunderbird-0.2_alpha20030807.ebuild,v 1.2 2003/08/11 19:39:41 brad Exp $

inherit makeedit flag-o-matic gcc nsplugins

# Added to get thunderbird to compile on sparc.
replace-sparc64-flags

S=${WORKDIR}/mozilla
MOZ_CO_DATE="20030807"

DESCRIPTION="Thunderbird Mail Client"
HOMEPAGE="http://www.mozilla.org/projects/thunderbird/"
SRC_URI="mirror://gentoo/MozillaThunderbird-${MOZ_CO_DATE}-source.tar.bz2"

KEYWORDS="~x86 ~ppc ~sparc ~alpha"
SLOT="0"
LICENSE="MPL-1.1 | NPL-1.1"
IUSE="gtk2 ipv6"

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
     =x11-libs/gtk+-1.2* ) "

DEPEND="${RDEPEND}
   virtual/glibc
   dev-lang/perl"
   
# needed by src_compile() and src_install()
export MOZ_THUNDERBIRD=1
export MOZ_ENABLE_XFT=1

src_unpack() {

	unpack MozillaThunderbird-${MOZ_CO_DATE}-source.tar.bz2

}

src_compile() {
   local myconf="--with-x \
      --with-system-jpeg \
      --with-system-zlib \
      --with-system-png \
      --with-system-mng \
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
      --with-pthreads \
      --with-default-mozilla-five-home=/usr/lib/MozillaThunderbird \
      --with-user-appdir=.thunderbird \
      --disable-jsd \
      --disable-accessibility \
      --disable-profilesharing \
      --disable-necko-disk-cache \
      --disable-activex-scripting \
      --disable-installer \
      --disable-activex \
      --disable-tests \
      --disable-debug \
      --disable-dtd-debug \
      --disable-logging \
      --enable-reorder \
	  --enable-optimize="-O3" \
      --enable-strip \
      --enable-strip-libs \
      --enable-cpp-rtti \
      --enable-xterm-updates \
      --disable-toolkit-qt \
      --disable-toolkit-xlib \
	  --enable-extensions=wallet \
	  --enable-necko-protocols=http,file,jar,viewsource,res,data \
	  --enable-image-decoders=png,gif,jpeg"

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
   filter-flags -ffast-math
   append-flags -s -fforce-addr

   if [ "$(gcc-major-version)" -eq "3" ]; then
      # Currently gcc-3.2 or older do not work well if we specify "-march"
      # and other optimizations for pentium4.
	  if [ "$(gcc-minor-version)" -lt "3" ]; then
	      replace-flags -march=pentium4 -march=pentium3
		  filter-flags -msse2
	  fi

   fi

   econf ${myconf} || die

   edit_makefiles
   emake MOZ_THUNDERBIRD=1 || die

}

src_install() {

   dodir /usr/lib
   dodir /usr/lib/MozillaThunderbird
   cp -RL --no-preserve=links ${S}/dist/bin/* ${D}/usr/lib/MozillaThunderbird

   #fix permissions
   chown -R root.root ${D}/usr/lib/MozillaThunderbird
   
   dobin ${FILESDIR}/MozillaThunderbird

	# Install icon and .desktop for menu entry
	if [ "`use gnome`" ]
	then
		insinto /usr/share/pixmaps
		doins ${S}/build/package/rpm/SOURCES/mozilla-icon.png

		# Fix comment of menu entry
		cd ${S}/build/package/rpm/SOURCES
		cp mozilla.desktop mozillathunderbird.desktop
		perl -pi -e 's:Name=Mozilla:Name=Mozilla Thunderbird:' mozillathunderbird.desktop
		perl -pi -e 's:Comment=Mozilla:Comment=Mozilla Thunderbird Mail Client:' mozillathunderbird.desktop
		perl -pi -e 's:Exec=/usr/bin/mozilla:Exec=/usr/bin/MozillaThunderbird:' mozillathunderbird.desktop
		cd ${S}
		insinto /usr/share/gnome/apps/Internet
		doins ${S}/build/package/rpm/SOURCES/mozillathunderbird.desktop
	fi

}

