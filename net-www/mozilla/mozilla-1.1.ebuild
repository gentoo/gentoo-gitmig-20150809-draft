# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/mozilla/mozilla-1.1.ebuild,v 1.2 2002/08/30 22:55:10 azarah Exp $

# NOTE: to build without the mail and news component:  export NO_MAIL="YES"
inherit makeedit

EMVER="0.65.2"
IPCVER="1.0.0.1"

# handle _rc versions
MY_PV1=${PV/_}
MY_PV2=${MY_PV1/eta}
S=${WORKDIR}/mozilla
DESCRIPTION="The Mozilla Web Browser"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla/releases/${PN}${MY_PV2}/src/${PN}-source-${MY_PV2}.tar.gz
	crypt? ( http://enigmail.mozdev.org/dload/src/enigmail-${EMVER}.tar.gz
	         http://enigmail.mozdev.org/dload/src/ipc-${IPCVER}.tar.gz )"
HOMEPAGE="http://www.mozilla.org"

KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"
LICENSE="MPL-1.1 | NPL-1.1"

RDEPEND=">=x11-base/xfree-4.2.0-r11
	>=gnome-base/ORBit-0.5.10-r1
	>=sys-libs/zlib-1.1.4
	>=media-libs/jpeg-6b
	>=media-libs/libmng-1.0.0
	>=media-libs/libpng-1.2.1
	>=sys-apps/portage-2.0.14
	dev-libs/expat
	app-arch/zip
	app-arch/unzip
	( gtk2? >=x11-libs/gtk+-2.0.5 :
	  =x11-libs/gtk+-1.2* )
	( gtk2? >=dev-libs/glib-2.0.4 :
	  =dev-libs/glib-1.2* )
	java?  ( virtual/jre )"

DEPEND="${RDEPEND}
	virtual/x11
	sys-devel/perl
	java? ( >=dev-java/java-config-0.2.0 )"

# needed by src_compile() and src_install()
export MOZILLA_OFFICIAL=1
export BUILD_OFFICIAL=1

# enable XFT
[ "${DISABLE_XFT}" != "1" ] && [ -z "`use gtk2`" ] && \
	export MOZ_ENABLE_XFT=1

# make sure the nss module gets build (for NSS support)
[ -n "`use ssl`" ] && export MOZ_PSM=1

# do we build java support for the NSS stuff ?
# NOTE: this is broken for the moment
#[ "`use java`" ] && export NS_USE_JDK=1


src_unpack() {
	
	unpack ${A}

	cd ${S}

	# Fix a ownership porblem
	chown -R root.root *

	[ -z "${CC}" ] && CC=gcc
	if [ "`${CC} -dumpversion | cut -d. -f1,2`" != "2.95" ] ; then
		# Fix bogus asm (from Mandrake .spec)
#		patch -p1 < ${FILESDIR}/mozilla-1.0-asmfixes.patch || die

		# ABI Patch for ppc/xpcom for gcc-3.x
		# http://bugzilla.mozilla.org/show_bug.cgi?id=142594
		if [ "${ARCH}" = "ppc" ] ; then
			patch -p0 < ${FILESDIR}/mozilla-1.0-abi-xpcom-ppc.patch || die
		fi
	fi

	# Apply the bytecode patch for freetype2
	patch -p1 < ${FILESDIR}/mozilla-ft-bytecode.patch || die

	# Unpack the enigmail plugin
	if [ -n "`use crypt`" ] && [ -z "`use moznomail`" ] && \
	   [ "${NO_MAIL}" != "YES" ] && [ "${NO_MAIL}" != "yes" ]
	then
		mv ${WORKDIR}/ipc ${S}/extensions/
		mv ${WORKDIR}/enigmail ${S}/extensions/
	fi
}

src_compile() {

	local myconf=""
	# NOTE: QT and XLIB toolkit seems very unstable, leave disabled until
	#       tested ok -- azarah
	if [ -n "`use gtk2`" ] ; then
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

	if [ -z "`use ldap`" ] ; then
		myconf="${myconf} --disable-ldap"
	fi

	if [ -z "${DEBUG}" ] ; then
		myconf="${myconf} --enable-strip-libs \
			              --disable-debug \
			              --disable-dtd-debug \
			              --disable-tests"
	fi

	if [ -n "${MOZ_ENABLE_XFT}" ] ; then
		# Enable Xft (currently this is done via freetype2 for gtk1,
		# and libpangoXft for gtk2).
		myconf="${myconf} --enable-xft"
	fi


	# NB!!:  Due to the fact that the non default extensions do not always
	#        compile properly, using them is considered unsupported, and
	#        is just here for completeness.  Please do not use if you 
	#        do not know what you are doing!
	#
	# The defaults are (as of 1.0rc1, according to configure (line ~10799)):
	#     cookie wallet content-packs xml-rpc xmlextras help transformiix venkman inspector irc
	# Non-defaults are:
	#     xmlterm access-builtin ctl p3p interfaceinfo
	local myext="default"
	if [ -n "`use mozxmlterm`" ] ; then
		myext="${myext},xmlterm"
	fi
	if [ -n "`use mozaccess-builtin`" ] ; then
		myext="${myext},access-builtin"
	fi
	if [ -n "`use mozctl`" ] ; then
		myext="${myext},ctl"
	fi
	if [ -n "`use mozp3p`" ] ; then
		myext="${myext},p3p"
	fi
	if [ -n "`use mozinterfaceinfo`" ] ; then
		myext="${myext},interfaceinfo"
	fi

	
	if [ -n "`use moznomail`" ] || \
	   [ "${NO_MAIL}" = "YES" ] || [ "${NO_MAIL}" = "yes" ]
	then
		myconf="${myconf} --disable-mailnews"
	fi
	
	export BUILD_MODULES=all
	export BUILD_OPT=1

	# Currently gcc-3.1.1 dont work well if we specify "-march"
	# and other optimizations for pentium4.
	[ -z "${CC}" ] && CC=gcc
	if [ "`${CC} -dumpversion | cut -d. -f1`" -eq "3" ] ; then
		export CFLAGS="${CFLAGS/pentium4/pentium3}"
		export CXXFLAGS="${CXXFLAGS/pentium4/pentium3}"
	fi
	
	#This should enable parallel builds, I hope
	export MAKE="emake"
		
	# Crashes on start when compiled with -fomit-frame-pointer
	CFLAGS="${CFLAGS/-fomit-frame-pointer}"
	CXXFLAGS="${CXXFLAGS/-fomit-frame-pointer} -Wno-deprecated"

	./configure --prefix=/usr/lib/mozilla \
		--disable-pedantic \
		--disable-svg \
		--enable-mathml \
		--without-system-nspr \
		--enable-nspr-autoconf \
		--with-system-zlib \
		--enable-ipv6 \
		--enable-xsl \
		--enable-crypto \
		--enable-detect-webshell-leaks \
		--enable-xinerama \
		--with-java-supplement \
		--with-pthreads \
		--with-extensions="${myext}" \
		--enable-optimize="-O3" \
		--with-default-mozilla-five-home=/usr/lib/mozilla \
		${myconf} || die

	edit_makefiles
	make || die

	# Build the NSS/SSL support
	if [ "`use ssl`" ] ; then
		cd ${S}/security/coreconf
		
		# Fix #include problem
		cp headers.mk headers.mk.orig
		echo 'INCLUDES += -I$(DIST)/include/nspr -I$(DIST)/include/dbm'\
			>>headers.mk

		make || die

		cd ${S}/security/nss
		
		make moz_import || die
		make || die
		cd ${S}
	fi

	# Build the enigmail plugin
	if [ -n "`use crypt`" ] && [ -z "`use moznomail`" ] && \
	   [ "${NO_MAIL}" != "YES" ] && [ "${NO_MAIL}" != "yes" ]
	then
		cd ${S}/extensions/ipc
		make || die

		cd ${S}/extensions/enigmail
		make || die
	fi
}

src_install() {

	# Install, don't create tarball
	dodir /usr/lib
	cd ${S}/xpinstall/packager
	einfo "Installing mozilla into build root..."
	make MOZ_PKG_FORMAT="raw" TAR_CREATE_FLAGS="-chf" > /dev/null || die
	mv -f ${S}/dist/mozilla ${D}/usr/lib/mozilla

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
	if [ "`use ssl`" ] ; then
		# Install the headers ('make install' do not work for headers ...)
		insinto /usr/lib/mozilla/include/nss
		doins ${S}/dist/public/seccmd/*.h
		doins ${S}/dist/public/security/*.h

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

	cd ${S}
	exeinto /usr/bin
	newexe ${FILESDIR}/mozilla.sh mozilla
	insinto /etc/env.d
	doins ${FILESDIR}/10mozilla
	dodoc LEGAL LICENSE README/mozilla/README*

	# Fix icons to look the same everywhere
	insinto /usr/lib/mozilla/icons
	doins ${S}/build/package/rpm/SOURCES/mozicon16.xpm
	doins ${S}/build/package/rpm/SOURCES/mozicon50.xpm

	# Install icon and .desktop for menu entry
	if [ "`use gnome`" ] ; then
		insinto /usr/share/pixmaps
		doins ${S}/build/package/rpm/SOURCES/mozilla-icon.png

		# Fix comment of menu entry
		cd ${S}/build/package/rpm/SOURCES
		cp mozilla.desktop mozilla.desktop.orig
		sed -e 's:Comment=Mozilla:Comment=Mozilla Web Browser:'	\
			mozilla.desktop.orig > mozilla.desktop
		cd ${S}
		insinto /usr/share/gnome/apps/Internet
		doins ${S}/build/package/rpm/SOURCES/mozilla.desktop
	fi

	if [ -n "${MOZ_ENABLE_XFT}" ] ; then
		cd ${D}/usr/lib/mozilla/defaults/pref
		patch -p0 <${FILESDIR}/mozilla-xft-unix-prefs.patch || \
			die "failed unix prefs patch"
	fi

	# Take care of non root execution
	# (seems the problem is that not all files are readible by the user)
	chmod -R g+r,o+r ${D}/usr/lib/mozilla
}

pkg_preinst() {
	# Stale components and chrome files break when unmerging old
	if [ -d ${ROOT}/usr/lib/mozilla/components ] ; then
		rm -rf ${ROOT}/usr/lib/mozilla/components
	fi
	if [ -d ${ROOT}/usr/lib/mozilla/chrome ] ; then
		rm -rf ${ROOT}/usr/lib/mozilla/chrome
	fi

	# Remove stale component registry.
    if [ -e ${ROOT}/usr/lib/component.reg ] ; then
		rm -f ${ROOT}/usr/lib/component.reg
	fi
}

pkg_postinst() {

	export MOZILLA_FIVE_HOME="${ROOT}/usr/lib/mozilla"

	# Make symlink for Java plugin (do not do in src_install(), else it only
	# gets installed every second time)
	if [ "`use java`" ] && [ ! -L ${MOZILLA_FIVE_HOME}/plugins/`java-config --browser-plugin=mozilla` ]
	then
		if [ -e `java-config --full-browser-plugin-path=mozilla` ]
		then
			ln -sf `java-config --full-browser-plugin-path=mozilla` \
				${MOZILLA_FIVE_HOME}/plugins/`java-config --browser-plugin=mozilla` 
		fi
	fi

	# We do not yet want any JAVA plugins with gcc-3.x, as they cause
	# mozilla to crash in some cases.
	[ -z "${CC}" ] && CC=gcc
	if [ "`${CC} -dumpversion | cut -d. -f1,2`" != "2.95" ] && [ "`use java`" ] ; then
		if [ -L ${MOZILLA_FIVE_HOME}/plugins/`java-config --browser-plugin=mozilla` ] ; then
			rm -f ${MOZILLA_FIVE_HOME}/plugins/`java-config --browser-plugin=mozilla`
		fi
	fi

	# Take care of component registration

	# Remove any stale component.reg
	if [ -e ${MOZILLA_FIVE_HOME}/component.reg ] ; then
		rm -f ${MOZILLA_FIVE_HOME}/component.reg
	fi

	# Tempory fix for missing libtimer_gtk.so
	# If it exists when generating component.reg (before unmerge of old),
	# it 'corrupts' the newly generated component.reg with invalid references.
	if [ -e ${MOZILLA_FIVE_HOME}/components/libtimer_gtk.so ] ; then
		rm -f ${MOZILLA_FIVE_HOME}/components/libtimer_gtk.so
	fi

	# Needed to update the run time bindings for REGXPCOM 
	# (do not remove next line!)
	env-update
	# Register components, setup Chrome .rdf files and fix file permissions
	einfo "Registering Components and Chrome..."
	umask 022
	${MOZILLA_FIVE_HOME}/regxpcom
	if [ -e ${MOZILLA_FIVE_HOME}/component.reg ] ; then
		chmod g+r,o+r ${MOZILLA_FIVE_HOME}/component.reg
	fi
	# Setup the default skin and locale to correctly generate the Chrome .rdf files
	find ${MOZILLA_FIVE_HOME}/chrome/ -name '*.rdf' -exec rm -f {} \; || :
	echo "skin,install,select,classic/1.0" >> \
		${MOZILLA_FIVE_HOME}/chrome/installed-chrome.txt
	echo "locale,install,select,en-US" >> \
		${MOZILLA_FIVE_HOME}/chrome/installed-chrome.txt
	${MOZILLA_FIVE_HOME}/regchrome
	find ${MOZILLA_FIVE_HOME}/ -type d -perm 0700 -exec chmod 755 {} \; || :


    echo
	einfo
	einfo "*****************************************************************"
	einfo "* NB:  Please unmerge old versions of mozilla, as the header    *"
	einfo "* layout in /usr/lib/mozilla/include have changed and will      *"
	einfo "* result in compile errors when compiling programs that need    *"
	einfo "* mozilla headers and libs (galeon, nautilus, ...)              *"
	einfo "*****************************************************************"
	echo
	einfo "*****************************************************************"
	einfo "* Any Errors seen during Component and Chrome registration is   *"
	einfo "* caused by pre 1.1 versions of mozilla being installed.        *"
	einfo "* Please unmerge older versions and everything should be fine.  *"
	einfo "*****************************************************************"
	einfo
}

pkg_postrm() {

	# Regenerate component.reg in case some things changed
	if [ -e ${ROOT}/usr/lib/mozilla/regxpcom ] ; then
	
		export MOZILLA_FIVE_HOME="${ROOT}/usr/lib/mozilla"
	
		if [ -e ${MOZILLA_FIVE_HOME}/component.reg ] ; then
			rm -f ${MOZILLA_FIVE_HOME}/component.reg
		fi

		${MOZILLA_FIVE_HOME}/regxpcom
		if [ -e ${MOZILLA_FIVE_HOME}/component.reg ] ; then
			chmod g+r,o+r ${MOZILLA_FIVE_HOME}/component.reg
		fi

		find ${MOZILLA_FIVE_HOME}/chrome/ -name '*.rdf' -exec rm -f {} \; || :
		${MOZILLA_FIVE_HOME}/regchrome
		find ${MOZILLA_FIVE_HOME}/ -type d -perm 0700 -exec chmod 755 {} \; || :
	fi
}

