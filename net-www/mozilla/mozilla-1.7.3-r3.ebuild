# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mozilla/mozilla-1.7.3-r3.ebuild,v 1.1 2004/11/18 14:04:33 agriffis Exp $

unset ALLOWED_FLAGS  # stupid extra-functions.sh ... bug 49179
inherit flag-o-matic gcc eutils nsplugins mozilla-launcher mozconfig makeedit

IUSE="java crypt ssl moznomail"

EMVER="0.89.0"
IPCVER="1.1.1"

# handle _rc versions
MY_PV=${PV/_alpha/a} 	# handle alpha
MY_PV=${MY_PV/_beta/b}	# handle beta
MY_PV=${MY_PV/_rc/rc}	# handle rc

DESCRIPTION="Mozilla Application Suite - web browser, email, HTML editor, IRC"
HOMEPAGE="http://www.mozilla.org"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/mozilla/releases/${PN}${MY_PV}/src/${PN}-source-${MY_PV}.tar.bz2
	crypt? ( !moznomail? (
		http://downloads.mozdev.org/enigmail/src/ipc-${IPCVER}.tar.gz
		http://downloads.mozdev.org/enigmail/src/enigmail-${EMVER}.tar.gz
	) )"

KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~ia64"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"

RDEPEND="java? ( virtual/jre )
	mozsvg? ( x11-libs/cairo )
	crypt? ( !moznomail? ( >=app-crypt/gnupg-1.2.1 ) )"

DEPEND="${RDEPEND}
	java? ( >=dev-java/java-config-0.2.0 )
	dev-lang/perl"

S="${WORKDIR}/mozilla"

src_unpack() {
	typeset x

	unpack ${A} || die "unpack failed"
	cd ${S} || die "cd failed"

	if [[ $(gcc-major-version) -eq 3 ]]; then
		# ABI Patch for alpha/xpcom for gcc-3.x
		if [[ ${ARCH} == alpha ]]; then
			epatch ${FILESDIR}/${PN}-alpha-xpcom-subs-fix.patch
		fi
	fi

	# Fix logic error when using RAW target
	# <azarah@gentoo.org> (23 Feb 2003)
	epatch ${FILESDIR}/1.3/${PN}-1.3-fix-RAW-target.patch

	# patch out ft caching code since the API changed between releases of
	# freetype; this enables freetype-2.1.8+ compat.
	# https://bugzilla.mozilla.org/show_bug.cgi?id=234035#c65
	epatch ${FILESDIR}/mozilla-1.7.3-4ft2.patch

	WANT_AUTOCONF=2.1 autoconf || die "WANT_AUTOCONF failed"

	# Unpack the enigmail plugin
	if use crypt && ! use moznomail; then
		for x in ipc enigmail; do
			mv ${WORKDIR}/${x} ${S}/extensions || die "mv failed"
			cd ${S}/extensions/${x} || die "cd failed"
			makemake	# from mozilla.eclass
		done
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

	# Other moz-specific settings
	mozconfig_use_enable mozdevelop jsd
	mozconfig_use_enable mozdevelop xpctools
	mozconfig_use_extension mozdevelop venkman
	mozconfig_use_enable gnome gnomevfs
	mozconfig_use_extension gnome gnomevfs
	mozconfig_use_extension !moznoirc irc
	mozconfig_use_extension mozxmlterm xmlterm
	mozconfig_use_enable mozcalendar calendar
	mozconfig_use_enable ldap
	mozconfig_use_enable ldap ldap-experimental
	mozconfig_use_enable mozsvg svg
	mozconfig_use_enable mozsvg svg-renderer-cairo
	mozconfig_annotate '' --prefix=/usr/lib/mozilla
	mozconfig_annotate '' --with-default-mozilla-five-home=/usr/lib/mozilla

	if use moznomail && ! use mozcalendar; then
		mozconfig_annotate "+moznomail -mozcalendar" --disable-mailnews
	fi
	if use moznocompose && use moznomail; then
		mozconfig_annotate "+moznocompose +moznomail" --disable-composer
	fi

	# Finalize and report settings
	mozconfig_final

	####################################
	#
	#  Configure and build Mozilla
	#
	####################################

	# ./configure picks up the mozconfig stuff
	./configure || die "configure failed"

	# This removes extraneous CFLAGS from the Makefiles to reduce RAM
	# requirements while compiling
	edit_makefiles

	emake || die "emake failed"

	####################################
	#
	#  Build Mozilla NSS
	#
	####################################

	# Build the NSS/SSL support
	if use ssl; then
		einfo "Building Mozilla NSS..."

		# Fix #include problem
		cd ${S}/security/coreconf || die "cd coreconf failed"
		echo 'INCLUDES += -I$(DIST)/include/nspr -I$(DIST)/include/dbm'\
			>>headers.mk
		emake -j1 || die "make security headers failed"

		cd ${S}/security/nss || die "cd nss failed"
		emake -j1 moz_import || die "make moz_import failed"
		emake -j1 || die "make nss failed"
	fi

	####################################
	#
	#  Build Enigmail plugin
	#
	####################################

	# Build the enigmail plugin
	if use crypt && ! use moznomail; then
		einfo "Building Enigmail plugin..."
		cd ${S}/extensions/ipc || die "cd ipc failed"
		emake || die "make ipc failed"

		cd ${S}/extensions/enigmail || die "cd enigmail failed"
		emake || die "make enigmail failed"
	fi
}

src_install() {
	# Install, don't create tarball
	dodir /usr/lib
	cd ${S}/xpinstall/packager
	einfo "Installing mozilla into build root..."
	make MOZ_PKG_FORMAT="RAW" TAR_CREATE_FLAGS="-chf" > /dev/null || die "make failed"
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
		export SOURCE_BIN_DIR=${WORKDIR}/nss/bin
		export SOURCE_LIB_DIR=${WORKDIR}/nss/lib

		make install || die "make failed"
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
	dosym /usr/libexec/mozilla-launcher /usr/bin/mozilla
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
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/icon/mozilla-icon.png
	insinto /usr/share/applications
	doins ${FILESDIR}/icon/mozilla.desktop

	# Take care of non root execution
	# (seems the problem is that not all files are readible by the user)
	einfo "Fixing Permissions..."
	chmod -R g+r,o+r ${D}/usr/lib/mozilla
	find ${D}/usr/lib/mozilla/ -type d -exec chmod 0755 {} \; || :
}

pkg_preinst() {
	# Move old plugins dir
	pkg_mv_plugins /usr/lib/mozilla/plugins

	if true; then
		# Remove entire installed instance to solve various problems,
		# for example see bug 27719
		rm -rf ${ROOT}/usr/lib/mozilla
	else
		# Stale components and chrome files break when unmerging old
		rm -rf ${ROOT}/usr/lib/mozilla/components
		rm -rf ${ROOT}/usr/lib/mozilla/chrome

		# Remove stale component registry.
		rm -f ${ROOT}/usr/lib/mozilla/component.reg
		rm -f ${ROOT}/usr/lib/mozilla/components/compreg.dat

		# Make sure these are removed.
		rm -f ${ROOT}/usr/lib/mozilla/lib{Xft,Xrender}.so*
	fi
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
	find ${MOZILLA_FIVE_HOME}/ -type d -perm 0700 -exec chmod 0755 {} \;

	# Fix permissions on chrome files
	find ${MOZILLA_FIVE_HOME}/chrome/ -name '*.rdf' -exec chmod 0644 {} \;

	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	# Regenerate component.reg in case some things changed
	if [[ -e ${ROOT}/usr/lib/mozilla/regxpcom ]]; then
		export MOZILLA_FIVE_HOME="${ROOT}/usr/lib/mozilla"

		if [[ -x ${MOZILLA_FIVE_HOME}/mozilla-rebuild-databases.pl ]]; then
			${MOZILLA_FIVE_HOME}/mozilla-rebuild-databases.pl
			# Fix directory permissions
			find ${MOZILLA_FIVE_HOME}/ -type d -perm 0700 -exec chmod 755 {} \;
			# Fix permissions on chrome files
			find ${MOZILLA_FIVE_HOME}/chrome/ -name '*.rdf' -exec chmod 0644 {} \;
		fi
	fi

	update_mozilla_launcher_symlinks
}
