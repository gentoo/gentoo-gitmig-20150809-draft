# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mozilla/mozilla-1.3-r1.ebuild,v 1.6 2003/05/22 04:25:42 azarah Exp $

IUSE="java crypt ipv6 gtk2 ssl ldap gnome"
# Internal USE flags that I do not really want to advertise ...
IUSE="${IUSE} mozsvg mozcalendar mozaccess mozinterfaceinfo mozp3p mozxmlterm"
IUSE="${IUSE} moznoirc moznomail moznocompose moznoxft"

inherit flag-o-matic gcc eutils nsplugins

# Crashes on start when compiled with -fomit-frame-pointer
filter-flags "-fomit-frame-pointer"

# Sparc support ...
replace-flags "-mcpu=ultrasparc" "-mcpu=v8 -mtune=ultrasparc"
replace-flags "-mcpu=v9" "-mcpu=v8 -mtune=v9"

# Recently there has been a lot of stability problem in Gentoo-land.  Many
# things can be the cause to this, but I believe that it is due to gcc3
# still having issues with optimizations, or with it not filtering bad
# combinations (protecting the user maybe from himeself) yet.
#
# This can clearly be seen in large builds like glibc, where too aggressive
# CFLAGS cause the tests to fail miserbly.
#
# Quote from Nick Jones <carpaski@gentoo.org>, who in my opinion
# knows what he is talking about:
#
#   People really shouldn't force code-specific options on... It's a
#   bad idea. The -march options aren't just to look pretty. They enable
#   options that are sensible (and include sse,mmx,3dnow when apropriate).
#
# The next command strips CFLAGS and CXXFLAGS from nearly all flags.  If
# you do not like it, comment it, but do not bugreport if you run into
# problems.
#
# <azarah@gentoo.org> (13 Oct 2002)
strip-flags

# We set -O in ./configure to -O1, as -O2 cause crashes on startup ...
# (bug #13287)
export CFLAGS="${CFLAGS//-O?}"
export CXXFLAGS="${CFLAGS//-O?}"

EMVER="0.74.3"
IPCVER="1.0.2"

PATCH_VER="1.0"

# handle _rc versions
MY_PV1="${PV/_}"
MY_PV2="${MY_PV1/eta}"
S="${WORKDIR}/mozilla"
DESCRIPTION="The Mozilla Web Browser"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla/releases/${PN}${MY_PV2}/src/${PN}-source-${MY_PV2}.tar.bz2
	crypt? ( http://enigmail.mozdev.org/dload/src/enigmail-${EMVER}.tar.gz
	         http://downloads.mozdev.org/enigmail/ipc-${IPCVER}.tar.gz )"
#	mirror://gentoo/${P}-patches-${PATCH_VER}.tar.bz2"
HOMEPAGE="http://www.mozilla.org"

KEYWORDS="x86 ~ppc ~sparc ~alpha"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"

RDEPEND=">=x11-base/xfree-4.2.0-r11
	>=gnome-base/ORBit-0.5.10-r1
	>=dev-libs/libIDL-0.8.0
	>=sys-libs/zlib-1.1.4
	>=media-libs/fontconfig-2.1
	virtual/xft
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.1
	>=sys-apps/portage-2.0.14
	dev-libs/expat
	app-arch/zip
	app-arch/unzip
	( gtk2? >=x11-libs/gtk+-2.2.0 :
	        =x11-libs/gtk+-1.2* )
	( gtk2? >=dev-libs/glib-2.2.0 :
	        =dev-libs/glib-1.2* )
	gtk2?  ( >=x11-libs/pango-1.2.1 )
	java?  ( virtual/jre )
	crypt? ( >=app-crypt/gnupg-1.2.1 )"

DEPEND="${RDEPEND}
	virtual/x11
	dev-util/pkgconfig
	dev-lang/perl
	java? ( >=dev-java/java-config-0.2.0 )"


moz_setup() {

	# Setup CC and CXX
	if [ -z "${CC}" ]
	then
		export CC="gcc"
	fi
	if [ -z "${CXX}" ]
	then
		export CXX="g++"
	fi

	#This should enable parallel builds, I hope
	if [ -f /proc/cpuinfo ]
	then
		# Set MAKEOPTS to have proper -j? option ..
		get_number_of_jobs
		export MAKE="emake"
	fi

	# needed by src_compile() and src_install()
	export MOZILLA_OFFICIAL=1
	export BUILD_OFFICIAL=1

	# make sure the nss module gets build (for NSS support)
	if [ -n "`use ssl`" ]
	then
		export MOZ_PSM="1"
	fi

	# do we build java support for the NSS stuff ?
	# NOTE: this is broken for the moment
#	if [ "`use java`" ]
#	then
#		export NS_USE_JDK="1"
#	fi
}

src_unpack() {

	moz_setup
	
	unpack ${A}

	cd ${S}

	if [ "$(gcc-major-version)" -eq "3" ]
	then
		# ABI Patch for alpha/xpcom for gcc-3.x
		if [ "${ARCH}" = "alpha" ]
		then
			cd ${S}; epatch ${FILESDIR}/${PN}-alpha-xpcom-subs-fix.patch
		fi
	fi

	epatch ${FILESDIR}/1.2/${PN}-1.2b-default-plugin-less-annoying.patch.bz2
	epatch ${FILESDIR}/1.2/${PN}-1.2b-over-the-spot.patch.bz2
	epatch ${FILESDIR}/1.2/${PN}-1.2b-wallet.patch.bz2

	# Fix logic error when using RAW target
	# <azarah@gentoo.org> (23 Feb 2003)
	epatch ${FILESDIR}/1.3/${PN}-1.3-fix-RAW-target.patch

	if [ -n "`use gtk2`" ]
	then
		epatch ${FILESDIR}/1.3/${PN}-1.3-gtk2.patch
	else
		epatch ${FILESDIR}/1.3/${PN}-1.3-fix-gtkim.patch
	fi

	export WANT_AUTOCONF_2_1=1
	autoconf &> /dev/null
	unset WANT_AUTOCONF_2_1

	# Unpack the enigmail plugin
	if [ -n "`use crypt`" -a -z "`use moznomail`" ]
	then
		mv -f ${WORKDIR}/ipc ${S}/extensions/
		mv -f ${WORKDIR}/enigmail ${S}/extensions/
	fi
}

src_compile() {

	moz_setup

	local myconf=""
	# NOTE: QT and XLIB toolkit seems very unstable, leave disabled until
	#       tested ok -- azarah
	if [ -n "`use gtk2`" ]
	then
		myconf="${myconf} --enable-toolkit-gtk2 \
		                  --enable-default-toolkit=gtk2 \
		                  --disable-toolkit-qt \
		                  --disable-toolkit-xlib \
		                  --disable-toolkit-gtk"
	else
		myconf="${myconf} --enable-toolkit-gtk \
			              --enable-default-toolkit=gtk \
			              --disable-toolkit-qt \
			              --disable-toolkit-xlib \
			              --disable-toolkit-gtk2"
	fi

	if [ -z "`use ldap`" ]
	then
		myconf="${myconf} --disable-ldap"
	fi

	if [ "${DEBUGBUILD}" != "yes" ]
	then
		myconf="${myconf} --enable-strip-libs \
			              --disable-debug \
			              --disable-tests \
						  --enable-reorder \
						  --enable-strip"
#						  --enable-cpp-rtti"

		# Currently --enable-elf-dynstr-gc only works for x86 and ppc,
		# thanks to Jason Wever <weeve@gentoo.org> for the fix.
		if [ -n "`use x86`" -o -n "`use ppc`" ]
		then
			myconf="${myconf} --enable-elf-dynstr-gc"
		fi
	fi

	# Check if we should enable Xft support ...
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

	if [ -n "`use ipv6`" ]
	then
		myconf="${myconf} --enable-ipv6"
	fi


	# NB!!:  Due to the fact that the non default extensions do not always
	#        compile properly, using them is considered unsupported, and
	#        is just here for completeness.  Please do not use if you 
	#        do not know what you are doing!
	#
	# The defaults are (as of 1.2, according to configure (line ~11445)):
	#     cookie, wallet, content-packs, xml-rpc, xmlextras, help, pref, transformiix,
	#     venkman, inspector, irc, universalchardet, typeaheadfind
	# Non-defaults are:
	#     xmlterm access-builtin p3p interfaceinfo datetime finger cview
	local myext="default"
	if [ -n "`use mozxmlterm`" ]
	then
		myext="${myext},xmlterm"
	fi
	if [ -n "`use mozaccess-builtin`" ]
	then
		myext="${myext},access-builtin"
	fi
	if [ -n "`use mozp3p`" ]
	then
		myext="${myext},p3p"
	fi
	if [ -n "`use mozinterfaceinfo`" ]
	then
		myext="${myext},interfaceinfo"
	fi
	if [ -n "`use moznoirc`" ]
	then
		myext="${myext},-irc"
	fi

	if [ -n "`use mozsvg`" ]
	then
		export MOZ_INTERNAL_LIBART_LGPL="1"
		myconf="${myconf} --enable-svg"
	else
		myconf="${myconf} --disable-svg"
	fi
# This puppy needs libical, which is not in portage yet.  Also make mozilla
# depend on swig, so not sure if its the best idea around to enable ...
#	if [ -n "`use mozcalendar`" ]
#	then
#		myconf="${myconf} --enable-calendar"
#	fi
	
	if [ -n "`use moznomail`" ]
	then
		myconf="${myconf} --disable-mailnews"
	fi
	if [ -n "`use moznocompose`" -a -n "`use moznomail`" ]
	then
		myconf="${myconf} --disable-composer"
	fi
	
	if [ "$(gcc-major-version)" -eq "3" ]
	then
		# Currently gcc-3.2 or older do not work well if we specify "-march"
		# and other optimizations for pentium4.
		export CFLAGS="${CFLAGS/-march=pentium4/-march=pentium3}"
		export CXXFLAGS="${CXXFLAGS/-march=pentium4/-march=pentium3}"

		# Enable us to use flash, etc plugins compiled with gcc-2.95.3
		if [ "${ARCH}" = "x86" ]
		then
			myconf="${myconf} --enable-old-abi-compat-wrappers"
		fi
	fi

	# *********************************************************************
	#
	#  Configure and build Mozilla
	#
	# *********************************************************************
	
	export BUILD_MODULES=all
	export BUILD_OPT=1
	
	# Get it to work without warnings on gcc3
	export CXXFLAGS="${CXXFLAGS} -Wno-deprecated"

	cd ${S}
	einfo "Configuring Mozilla..."
	./configure --prefix=/usr/lib/mozilla \
		--disable-pedantic \
		--disable-short-wchar \
		--disable-xprint \
		--enable-mathml \
		--without-system-nspr \
		--enable-nspr-autoconf \
		--with-system-zlib \
		--enable-xsl \
		--enable-crypto \
		--enable-extensions="${myext}" \
		--enable-optimize="-O2" \
		--with-default-mozilla-five-home=/usr/lib/mozilla \
		${myconf} || die

	einfo "Building Mozilla..."
	make WORKDIR="${WORKDIR}" || die

	# *********************************************************************
	#
	#  Build Mozilla NSS
	#
	# *********************************************************************

	# Build the NSS/SSL support
	if [ "`use ssl`" ]
	then
		einfo "Building Mozilla NSS..."
		cd ${S}/security/coreconf
		
		# Fix #include problem
		cp headers.mk headers.mk.orig
		echo 'INCLUDES += -I$(DIST)/include/nspr -I$(DIST)/include/dbm'\
			>>headers.mk

		# Disable jobserver here ...
		make MAKE="make" || die

		cd ${S}/security/nss
		
		# Disable jobserver here ...
		make MAKE="make" moz_import || die
		make MAKE="make" || die
		cd ${S}
	fi

	# *********************************************************************
	#
	#  Build Enigmail plugin
	#
	# *********************************************************************

	# Build the enigmail plugin
	if [ -n "`use crypt`" -a -z "`use moznomail`" ]
	then
		einfo "Building Enigmail plugin..."
		cd ${S}/extensions/ipc
		make || die

		cd ${S}/extensions/enigmail
		make || die
	fi
}

src_install() {

	moz_setup

	# Install, don't create tarball
	dodir /usr/lib
	cd ${S}/xpinstall/packager
	einfo "Installing mozilla into build root..."
	make MOZ_PKG_FORMAT="RAW" TAR_CREATE_FLAGS="-chf" > /dev/null || die
	mv -f ${S}/dist/mozilla ${D}/usr/lib/mozilla

	einfo "Installing includes and idl files..."
	# Copy the include and idl files
	dodir /usr/lib/mozilla/include/idl /usr/include
	cd ${S}/dist
	cp -LfR include/* ${D}/usr/lib/mozilla/include
	cp -LfR idl/* ${D}/usr/lib/mozilla/include/idl
	dosym /usr/lib/mozilla/include /usr/include/mozilla

	# Install the development tools in /usr
	dodir /usr/bin
	mv ${D}/usr/lib/mozilla/{xpcshell,xpidl,xpt_dump,xpt_link} ${D}/usr/bin

	# Install the NSS/SSL libs, headers and tools
	if [ "`use ssl`" ]
	then
		einfo "Installing Mozilla NSS..."
		# Install the headers ('make install' do not work for headers ...)
		insinto /usr/lib/mozilla/include/nss
		[ -d ${S}/dist/public/nss ] && doins ${S}/dist/public/nss/*.h
		[ -d ${S}/dist/public/seccmd ] && doins ${S}/dist/public/seccmd/*.h
		[ -d ${S}/dist/public/security ] && doins ${S}/dist/public/security/*.h
		# These come with zlib ...
		rm -f ${D}/usr/lib/mozilla/include/nss/{zconf.h,zlib.h}

		cd ${S}/security/nss

		mkdir -p ${WORKDIR}/nss/{bin,lib}
		export BUILD_OPT=1
		export SOURCE_BIN_DIR=${WORKDIR}/nss/bin
		export SOURCE_LIB_DIR=${WORKDIR}/nss/lib

		make install || die
		# Gets installed as symbolic links ...
		cp -Lf ${WORKDIR}/nss/bin/* ${D}/usr/bin
		cp -Lf ${WORKDIR}/nss/lib/* ${D}/usr/lib/mozilla

		# Need to unset these incase we want to rebuild, else the build
		# gets newked.
		unset SOURCE_LIB_DIR
		unset SOURCE_BIN_DIR
	fi

	cd ${S}/build/unix
	# Fix mozilla-config and install it
	perl -pi -e "s:/lib/mozilla-${MY_PV2}::g" mozilla-config
	perl -pi -e "s:/mozilla-${MY_PV2}::g" mozilla-config
	exeinto /usr/lib/mozilla
	doexe mozilla-config
	# Fix pkgconfig files and install them
	insinto /usr/lib/pkgconfig
	for x in *.pc
	do
		if [ -f ${x} ]
		then
			perl -pi -e "s:/lib/mozilla-${MY_PV2}::g" ${x}
			perl -pi -e "s:/mozilla-${MY_PV2}::g" ${x}
			doins ${x}
		fi
	done

	cd ${S}
	exeinto /usr/bin
	newexe ${FILESDIR}/mozilla.sh mozilla
	insinto /etc/env.d
	doins ${FILESDIR}/10mozilla
	dodoc LEGAL LICENSE README/mozilla/README*

	# Install rebuild script
	exeinto /usr/lib/mozilla/
	newexe ${S}/build/package/rpm/SOURCES/mozilla-rebuild-databases.pl.in \
		mozilla-rebuild-databases.pl
	dosed 's|LIBDIR|/usr/lib|g' /usr/lib/mozilla/mozilla-rebuild-databases.pl
	dosed 's|-MOZILLA_VERSION||g' /usr/lib/mozilla/mozilla-rebuild-databases.pl

	# Move plugins dir
	src_mv_plugins /usr/lib/mozilla/plugins

	# Update Google search plugin to use UTF8 charset ...
	insinto /usr/lib/mozilla/searchplugins
	doins ${FILESDIR}/google.src

	if [ -f "${WORKDIR}/.xft" ]
	then
		# We are using Xft, so change the default font
		insinto /usr/lib/mozilla/defaults/pref
		doins ${FILESDIR}/xft.js
	fi

	# Fix icons to look the same everywhere
	insinto /usr/lib/mozilla/icons
	doins ${S}/build/package/rpm/SOURCES/mozicon16.xpm
	doins ${S}/build/package/rpm/SOURCES/mozicon50.xpm

	# Install icon and .desktop for menu entry
	if [ "`use gnome`" ]
	then
		insinto /usr/share/pixmaps
		doins ${S}/build/package/rpm/SOURCES/mozilla-icon.png

		# Fix comment of menu entry
		cd ${S}/build/package/rpm/SOURCES
		perl -pi -e 's:Comment=Mozilla:Comment=Mozilla Web Browser:' mozilla.desktop
		cd ${S}
		insinto /usr/share/gnome/apps/Internet
		doins ${S}/build/package/rpm/SOURCES/mozilla.desktop
	fi

	# Take care of non root execution
	# (seems the problem is that not all files are readible by the user)
	einfo "Fixing Permissions..."
	chmod -R g+r,o+r ${D}/usr/lib/mozilla
	find ${D}/usr/lib/mozilla/ -type d -exec chmod 0755 {} \; || :
}

pkg_preinst() {
	# Stale components and chrome files break when unmerging old
	if [ -d ${ROOT}/usr/lib/mozilla/components ]
	then
		rm -rf ${ROOT}/usr/lib/mozilla/components
	fi
	if [ -d ${ROOT}/usr/lib/mozilla/chrome ]
	then
		rm -rf ${ROOT}/usr/lib/mozilla/chrome
	fi

	# Remove stale component registry.
    if [ -e ${ROOT}/usr/lib/mozilla/component.reg ]
	then
		rm -f ${ROOT}/usr/lib/mozilla/component.reg
	fi
	if [ -e ${ROOT}/usr/lib/mozilla/components/compreg.dat ]
	then
		rm -f ${ROOT}/usr/lib/mozilla/components/compreg.dat
	fi

	# Make sure these are removed.
	rm -f ${ROOT}/usr/lib/mozilla/lib{Xft,Xrender}.so*

	# Move old plugins dir
	pkg_mv_plugins /usr/lib/mozilla/plugins
}

pkg_postinst() {

	export MOZILLA_FIVE_HOME="${ROOT}/usr/lib/mozilla"

	# Needed to update the run time bindings for REGXPCOM 
	# (do not remove next line!)
	env-update
	# Register Components and Chrome
	einfo "Registering Components and Chrome..."
	${MOZILLA_FIVE_HOME}/mozilla-rebuild-databases.pl
	# Fix permissions of component registry
	chmod 0644 ${MOZILLA_FIVE_HOME}/components/compreg.dat
	# Fix directory permissions
	find ${MOZILLA_FIVE_HOME}/ -type d -perm 0700 -exec chmod 0755 {} \; || :
	# Fix permissions on chrome files
	find ${MOZILLA_FIVE_HOME}/chrome/ -name '*.rdf' -exec chmod 0644 {} \; || :


	echo
	ewarn "Please unmerge old versions of mozilla, as the header"
	ewarn "layout in /usr/lib/mozilla/include have changed and will"
	ewarn "result in compile errors when compiling programs that need"
	ewarn "mozilla headers and libs (galeon, nautilus, ...)"
}

pkg_postrm() {

	# Regenerate component.reg in case some things changed
	if [ -e ${ROOT}/usr/lib/mozilla/regxpcom ]
	then
		export MOZILLA_FIVE_HOME="${ROOT}/usr/lib/mozilla"
	
		if [ -x "${MOZILLA_FIVE_HOME}/mozilla-rebuild-databases.pl" ]
		then
			${MOZILLA_FIVE_HOME}/mozilla-rebuild-databases.pl
			# Fix directory permissions
			find ${MOZILLA_FIVE_HOME}/ -type d -perm 0700 -exec chmod 755 {} \; || :
			# Fix permissions on chrome files
			find ${MOZILLA_FIVE_HOME}/chrome/ -name '*.rdf' -exec chmod 0644 {} \; || :
		fi
	fi
}

