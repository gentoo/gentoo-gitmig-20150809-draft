# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mozilla/mozilla-1.7_beta-r1.ebuild,v 1.5 2004/03/30 05:18:16 spyderous Exp $

IUSE="java crypt ipv6 gtk2 ssl ldap gnome debug xinerama"
# Internal USE flags that I do not really want to advertise ...
IUSE="${IUSE} mozcalendar mozaccess mozxmlterm"
IUSE="${IUSE} moznoirc moznomail moznocompose moznoxft"

inherit flag-o-matic gcc eutils nsplugins

# Strip over-aggressive CFLAGS - Mozilla supplies its own fine-tuned CFLAGS and shouldn't be interfered with
strip-flags

# Strip flags which create more documented instability
filter-flags "-fomit-frame-pointer"
filter-flags -ffast-math
append-flags -s -fforce-addr

# Merged ARCH stuff into a single case statement.  But shouldn't this
# stuff go in src_compile? (18 Nov 2003 agriffis)
case "${ARCH}" in
	alpha|ia64)
		# Anything more than this causes segfaults on startup on 64-bit
		# (bug 33767)
		export CFLAGS="${CFLAGS//-O[1-9s]/-O} -Wall -fPIC -pipe"
		export CXXFLAGS="${CXXFLAGS//-O[1-9s]/-O} -Wall -fPIC -pipe"
		;;
	amd64)
		# Anything more than this causes segfaults on startup on amd64
		# [Note: I think amd64 could use the same as above in the
		# alpha/ia64 section, but I'll let the amd64 devs choose. -agriffis]
		export CFLAGS="-O -Wall -fPIC -pipe"
		export CXXFLAGS="${CFLAGS}"
		;;
	ppc)
		# Fix to avoid gcc-3.3.x micompilation issues.
		if [[ $(gcc-major-version).$(gcc-minor-version) == 3.3 ]]; then
			append-flags -fno-strict-aliasing
		fi
		;;
	sparc)
		# Sparc support ...
		replace-sparc64-flags
		;;
	*)
		# We set -O in ./configure to -O1, as -O2 cause crashes on
		# startup (bug 13287)
		export CFLAGS="${CFLAGS//-O?}"
		export CXXFLAGS="${CFLAGS//-O?}"
		;;
esac

EMVER="0.83.5"
IPCVER="1.0.5"

PATCH_VER="1.0"

# handle _rc versions
MY_PV=${PV/_alpha/a} 	# handle alpha
MY_PV=${MY_PV/_beta/b}	# handle beta
S="${WORKDIR}/mozilla"
DESCRIPTION="The Mozilla Web Browser"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/mozilla/releases/${PN}${MY_PV}/src/${PN}-source-${MY_PV}-source.tar.bz2
	crypt? ( http://downloads.mozdev.org/enigmail/src/enigmail-${EMVER}.tar.gz
			 http://downloads.mozdev.org/enigmail/src/ipc-${IPCVER}.tar.gz )"
#	mirror://gentoo/${P}-patches-${PATCH_VER}.tar.bz2"
HOMEPAGE="http://www.mozilla.org"

KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~ia64"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"

RDEPEND="virtual/x11
	>=sys-libs/zlib-1.1.4
	>=media-libs/fontconfig-2.1
	!moznoxft ( virtual/xft )
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.1
	>=sys-apps/portage-2.0.14
	dev-libs/expat
	app-arch/zip
	app-arch/unzip
	gtk2? (
		>=x11-libs/gtk+-2.2.0
		>=dev-libs/glib-2.2.0
		>=x11-libs/pango-1.2.1
		>=dev-libs/libIDL-0.8.0 )
	!gtk2? (
		=x11-libs/gtk+-1.2*
		=dev-libs/glib-1.2*
		>=gnome-base/ORBit-0.5.10-r1 )
	java?  ( virtual/jre )
	crypt? ( >=app-crypt/gnupg-1.2.1 )
	gnome? ( >=gnome-base/gnome-vfs-2.3.5 )
	net-www/mozilla-launcher"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-lang/perl
	java? ( >=dev-java/java-config-0.2.0 )"


moz_setup() {
	# Set MAKEOPTS to have proper -j? option ..
	get_number_of_jobs

	# This should enable parallel builds, I hope
	export MAKE="emake"

	# needed by src_compile() and src_install()
	export MOZILLA_OFFICIAL=1
	export BUILD_OFFICIAL=1

	# make sure the nss module gets build (for NSS support)
	if use ssl; then
		export MOZ_PSM="1"
	fi
}

src_unpack() {
	moz_setup

	unpack ${A}

	cd ${S} || die

	if [[ $(gcc-major-version) -eq 3 ]]; then
		# ABI Patch for alpha/xpcom for gcc-3.x
		if [[ ${ARCH} == alpha ]]; then
			epatch ${FILESDIR}/${PN}-alpha-xpcom-subs-fix.patch
		fi
		if [[ ${ARCH} == amd64 ]]; then
			epatch ${FILESDIR}/${PN}-1.4-amd64.patch
		fi
	fi

	epatch ${FILESDIR}/1.2/${PN}-1.2b-default-plugin-less-annoying.patch.bz2

	# Fix logic error when using RAW target
	# <azarah@gentoo.org> (23 Feb 2003)
	epatch ${FILESDIR}/1.3/${PN}-1.3-fix-RAW-target.patch

	WANT_AUTOCONF_2_1=1 autoconf &> /dev/null

	# Unpack the enigmail plugin
	if use crypt && ! use moznomail; then
		mv -f ${WORKDIR}/ipc ${S}/extensions/
		mv -f ${WORKDIR}/enigmail ${S}/extensions/
		cp ${FILESDIR}/enigmail/Makefile-enigmail ${S}/extensions/enigmail/Makefile
		cp ${FILESDIR}/enigmail/Makefile-ipc ${S}/extensions/ipc/Makefile
	fi
}

src_compile() {
	moz_setup

	local myconf

	# NOTE: QT and XLIB toolkit seems very unstable, leave disabled until
	#       tested ok -- azarah
	if use gtk2; then
		myconf="${myconf}
			--enable-toolkit-gtk2 \
			--enable-default-toolkit=gtk2 \
			--disable-toolkit-qt \
			--disable-toolkit-xlib \
			--disable-toolkit-gtk"
	else
		myconf="${myconf}
			--enable-toolkit-gtk \
			--enable-default-toolkit=gtk \
			--disable-toolkit-qt \
			--disable-toolkit-xlib \
			--disable-toolkit-gtk2"
	fi

	if ! use debug; then
		myconf="${myconf} \
			--enable-strip-libs \
			--disable-debug \
			--disable-tests \
			--enable-reorder \
			--enable-strip"
#			--enable-cpp-rtti"

		# Currently --enable-elf-dynstr-gc only works for x86 and ppc,
		# thanks to Jason Wever <weeve@gentoo.org> for the fix.
		if use x86 || use ppc; then
			myconf="${myconf} --enable-elf-dynstr-gc"
		fi
	fi

	# Check if we should enable Xft support ...
	if ! use moznoxft; then
		if use gtk2; then
			local pango_version=""

			# We need Xft2.0 localy installed
			if [[ -x /usr/bin/pkg-config ]] && pkg-config xft; then
				pango_version=$(pkg-config --modversion pango | cut -d. -f1,2)

				# We also need pango-1.1, else Mozilla links to both
				# Xft1.1 *and* Xft2.0, and segfault...
				if [[ ${pango_version//.} -gt 10 ]]; then
					einfo "Building with Xft2.0 (Gtk+-2.0) support"
					myconf="${myconf} --enable-xft --disable-freetype2"
					touch ${WORKDIR}/.xft
				else
					ewarn "Building without Xft2.0 support (bad pango)"
					myconf="${myconf} --disable-xft $(use_enable truetype freetype2)"
				fi
			else
				ewarn "Building without Xft2.0 support (no pkg-config xft)"
				myconf="${myconf} --disable-xft $(use_enable truetype freetype2)"
			fi
		else
			einfo "Building with Xft2.0 (Gtk+-1.0) support"
			myconf="${myconf} --enable-xft --disable-freetype2"
			touch ${WORKDIR}/.xft
		fi
	else
		einfo "Building without Xft2.0 support (moznoxft)"
		myconf="${myconf} --disable-xft $(use_enable truetype freetype2)"
	fi

	# NB!!:  Due to the fact that the non default extensions do not always
	#        compile properly, using them is considered unsupported, and
	#        is just here for completeness.  Please do not use if you
	#        do not know what you are doing!
	#
	# The defaults are:
	# cookie wallet content-packs xml-rpc xmlextras help p3p pref transformiix
	# venkman inspector irc universalchardet typeaheadfind webservices
	# spellcheck
	# Non-defaults are:
	#     xmlterm access-builtin datetime finger cview
	if use mozxmlterm || use mozaccess; then
		ewarn ""
		ewarn "The use of the non-default extensions is considered unsupported, and these"
		ewarn "may not always compile properly."
		ewarn "Please do not use if you do not know what you're doing!"
		ewarn ""
		sleep 3
	fi

	local myext="default"
	use mozxmlterm && myext="${myext},xmlterm"
	use mozaccess  && myext="${myext},access-builtin"
	use moznoirc   && myext="${myext},-irc"

# Disable SVG until it's properly implemented
#	if use mozsvg; then
#		export MOZ_INTERNAL_LIBART_LGPL="1"
#		myconf="${myconf} --enable-svg"
#	else
#		myconf="${myconf} --disable-svg"
#	fi

	if use moznomail && ! use mozcalendar; then
		myconf="${myconf} --disable-mailnews"
	fi
	if use moznocompose && use moznomail; then
		myconf="${myconf} --disable-composer"
	fi

	if [[ $(gcc-major-version) -eq 3 ]]; then
		# Currently gcc-3.2 or older do not work well if we specify "-march"
		# and other optimizations for pentium4.
		if [[ $(gcc-minor-version) -lt 3 ]]; then
			replace-flags -march=pentium4 -march=pentium3
			filter-flags -msse2
		fi

		# Enable us to use flash, etc plugins compiled with gcc-2.95.3
		if [[ ${ARCH} == x86 ]]; then
			myconf="${myconf} --enable-old-abi-compat-wrappers"
		fi
	fi

	if use alpha; then
		# mozilla wont link with X11 on alpha, for some crazy reason.
		# set it to link explicitly here.
		sed -i 's/\(EXTRA_DSO_LDOPTS += $(MOZ_GTK_LDFLAGS).*$\)/\1 -L/usr/X11R6/lib -lX11/' \
			${S}/gfx/src/gtk/Makefile.in
	fi

	# Check for xinerama - closes #19369
	if use xinerama; then
		myconf="${myconf} --enable-xinerama=yes"
	else
		myconf="${myconf} --enable-xinerama=no"
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

	# On 64-bit we statically set 'safe' CFLAGS. Use those only.
	# using the standard -O2 will cause segfaults on startup
	case "${ARCH}" in
		alpha|amd64|ia64)
			ENABLE_OPTIMIZE="${CFLAGS}"
			;;
		*)
			ENABLE_OPTIMIZE="-O2"
			;;
	esac

	cd ${S}
	einfo "Configuring Mozilla..."
	./configure --prefix=/usr/lib/mozilla \
		$(use_enable gnome gnomevfs) \
		$(use_enable ipv6) \
		$(use_enable ldap) \
		$(use_enable mozcalendar calendar) \
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
		--enable-optimize="${ENABLE_OPTIMIZE}" \
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
	if use ssl; then
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
	if use crypt && ! use moznomail; then
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
	if use ssl; then
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
	perl -pi -e "s:/lib/mozilla-${MY_PV}::g" mozilla-config
	perl -pi -e "s:/mozilla-${MY_PV}::g" mozilla-config
	exeinto /usr/lib/mozilla
	doexe mozilla-config
	# Fix pkgconfig files and install them
	insinto /usr/lib/pkgconfig
	for x in *.pc; do
		if [[ -f ${x} ]]; then
			perl -pi -e "s:/lib/mozilla-${MY_PV}::g" ${x}
			perl -pi -e "s:/mozilla-${MY_PV}::g" ${x}
			doins ${x}
		fi
	done
	cd ${S}

	dodir /usr/bin
	dosym mozilla-launcher /usr/bin/mozilla
	insinto /etc/env.d
	doins ${FILESDIR}/10mozilla
	dodoc LEGAL LICENSE README/mozilla/README*

	# Install rebuild script
	exeinto /usr/lib/mozilla/
	doexe ${FILESDIR}/mozilla-rebuild-databases.pl

	# Move plugins dir
	src_mv_plugins /usr/lib/mozilla/plugins

	# Update Google search plugin to use UTF8 charset ...
	insinto /usr/lib/mozilla/searchplugins
	doins ${FILESDIR}/google.src

	if [[ -f "${WORKDIR}/.xft" ]]; then
		# We are using Xft, so change the default font
		insinto /usr/lib/mozilla/defaults/pref
		doins ${FILESDIR}/xft.js
	fi

	# Fix icons to look the same everywhere
	insinto /usr/lib/mozilla/icons
	doins ${S}/widget/src/gtk/mozicon16.xpm
	doins ${S}/widget/src/gtk/mozicon50.xpm

	# Install icon and .desktop for menu entry
	if use gnome; then
		insinto /usr/share/pixmaps
		doins ${FILESDIR}/icon/mozilla-icon.png

		insinto /usr/share/gnome/apps/Internet
		doins ${FILESDIR}/icon/mozilla.desktop
	fi

	# Take care of non root execution
	# (seems the problem is that not all files are readible by the user)
	einfo "Fixing Permissions..."
	chmod -R g+r,o+r ${D}/usr/lib/mozilla
	find ${D}/usr/lib/mozilla/ -type d -exec chmod 0755 {} \; || :
}

pkg_preinst() {
	# Stale components and chrome files break when unmerging old
	rm -rf ${ROOT}/usr/lib/mozilla/components
	rm -rf ${ROOT}/usr/lib/mozilla/chrome

	# Remove stale component registry.
	rm -f ${ROOT}/usr/lib/mozilla/component.reg
	rm -f ${ROOT}/usr/lib/mozilla/components/compreg.dat

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
	if [[ -e ${ROOT}/usr/lib/mozilla/regxpcom ]]; then
		export MOZILLA_FIVE_HOME="${ROOT}/usr/lib/mozilla"

		if [[ -x ${MOZILLA_FIVE_HOME}/mozilla-rebuild-databases.pl ]]; then
			${MOZILLA_FIVE_HOME}/mozilla-rebuild-databases.pl
			# Fix directory permissions
			find ${MOZILLA_FIVE_HOME}/ -type d -perm 0700 -exec chmod 755 {} \; || :
			# Fix permissions on chrome files
			find ${MOZILLA_FIVE_HOME}/chrome/ -name '*.rdf' -exec chmod 0644 {} \; || :
		fi
	fi
}

