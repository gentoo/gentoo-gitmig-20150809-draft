# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/mozilla/mozilla-1.7.11-r2.ebuild,v 1.1 2005/08/16 04:45:21 anarchy Exp $

unset ALLOWED_FLAGS  # stupid extra-functions.sh ... bug 49179
inherit flag-o-matic toolchain-funcs eutils mozconfig mozilla-launcher makeedit multilib

EMVER="0.92.0"
IPCVER="1.1.3"

# handle _rc versions
MY_PV=${PV/_alpha/a} 	# handle alpha
MY_PV=${MY_PV/_beta/b}	# handle beta
MY_PV=${MY_PV/_rc/rc}	# handle rc

DESCRIPTION="Mozilla Application Suite - web browser, email, HTML editor, IRC"
HOMEPAGE="http://www.mozilla.org"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/mozilla/releases/${PN}${MY_PV}/source/${PN}-${MY_PV}-source.tar.bz2
	crypt? ( !moznomail? (
		http://www.mozilla-enigmail.org/downloads/src/ipc-${IPCVER}.tar.gz
		http://www.mozilla-enigmail.org/downloads/src/enigmail-${EMVER}.tar.gz
	) )
	mirror://gentoo/mozilla-jslibmath-alpha.patch
	mirror://gentoo/mozilla-firefox-1.0-4ft2.patch.bz2
	http://dev.gentoo.org/~agriffis/dist/mozilla-1.7.10-nsplugins-v2.patch"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"
IUSE="crypt gnome java ldap mozcalendar mozdevelop moznocompose moznoirc moznomail mozsvg postgres ssl"

# xrender.pc appeared for the first time in xorg-x11-6.7.0-r2
# and is required to build with support for cairo.  #71504
RDEPEND="java? ( virtual/jre )
	mozsvg? (
		!<x11-base/xorg-x11-6.7.0-r2
		x11-libs/cairo
	)
	crypt? ( !moznomail? ( >=app-crypt/gnupg-1.2.1 ) )
	>=www-client/mozilla-launcher-1.42"

DEPEND="${RDEPEND}
	~sys-devel/autoconf-2.13
	java? ( >=dev-java/java-config-0.2.0 )
	dev-lang/perl
	postgres? ( >=dev-db/postgresql-7.2.0 )"

S=${WORKDIR}/mozilla

# Needed by src_compile() and src_install().
# Would do in pkg_setup but that loses the export attribute, they
# become pure shell variables.
#
# NB: We can't export these vars until enigmail is installed separately instead
# of integrated into this ebuild.
#
#export BUILD_OFFICIAL=1
#export MOZILLA_OFFICIAL=1

src_unpack() {
	declare x

	unpack mozilla-${MY_PV}-source.tar.bz2
	cd ${S} || die

	# Unpack the enigmail plugin
	if use crypt && ! use moznomail; then
		cd ${S}/extensions || die
		unpack ipc-${IPCVER}.tar.gz enigmail-${EMVER}.tar.gz
		for x in ipc enigmail; do
			cd ${S}/extensions/${x} || die "cd failed"
			makemake	# from mozconfig.eclass
		done
	fi
	cd ${S}

	####################################
	#
	# architecture patches
	#
	####################################

	if [[ $(gcc-major-version) -eq 3 ]]; then
		# ABI Patch for alpha/xpcom for gcc-3.x
		if [[ ${ARCH} == alpha ]]; then
			epatch ${FILESDIR}/${PN}-alpha-xpcom-subs-fix.patch
		fi
	fi

	# HPPA patches from Ivar <orskaug@stud.ntnu.no>
	# <gmsoft@gentoo.org> (22 Dec 2004)
	epatch ${FILESDIR}/mozilla-hppa.patch

	# patch to fix math operations on alpha, makes maps.google.com work!
	epatch ${DISTDIR}/mozilla-jslibmath-alpha.patch

	# Patch to allow compilation on ppc64 - bug #54843
	use ppc64 && epatch ${FILESDIR}/mozilla-1.7.6-ppc64.patch

	# Fix building on amd64 with gcc4 (patch from Debian)
	epatch ${FILESDIR}/${PN}-1.7.8-amd64.patch

	####################################
	#
	# general compilation and run-time fixes
	#
	####################################

	# GCC4 compile fix, bug #87800
	epatch ${FILESDIR}/${PN}-1.7.6-gcc4.patch

	# Fix stack growth logic
	epatch ${FILESDIR}/${PN}-stackgrowth.patch

	# patch out ft caching code since the API changed between releases of
	# freetype; this enables freetype-2.1.8+ compat.
	# https://bugzilla.mozilla.org/show_bug.cgi?id=234035#c65
	epatch ${DISTDIR}/mozilla-firefox-1.0-4ft2.patch.bz2

	# Patch for newer versions of cairo #80301
	if has_version '>=x11-libs/cairo-0.3.0'; then
		epatch ${FILESDIR}/svg-cairo-0.3.0-fix.patch
	fi

	####################################
	#
	# behavioral fixes
	#
	####################################

	# Mozilla Bug 292257, https://bugzilla.mozilla.org/show_bug.cgi?id=292257
	# Mozilla crashes under some rare cases when plugin.default_plugin_disabled
	# is true. This patch fixes that. Backported by hansmi@gentoo.org.
	epatch ${FILESDIR}/${PN}-1.7.8-objectframefix.diff

	# Fix scripts that call for /usr/local/bin/perl #51916
	ebegin "Patching smime to call perl from /usr/bin"
	sed -i -e '1s,usr/local/bin,usr/bin,' security/nss/cmd/smimetools/smime
	eend $? || die "sed failed"

	# look in /usr/lib/nsplugins for plugins, in addition to the usual places
	epatch ${DISTDIR}/mozilla-1.7.10-nsplugins-v2.patch

	#rpath patch
	epatch ${FILESDIR}/mozilla-rpath-1.patch

	WANT_AUTOCONF=2.1 autoconf || die "WANT_AUTOCONF failed"
}

src_compile() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}
	declare x

	grep -Flr "#RPATH_FIXER" --include=*.mk . | xargs sed -i -e \
		's|#RPATH_FIXER|'"${MOZILLA_FIVE_HOME}"'|'
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
	mozconfig_use_extension postgres sql
	if use postgres ; then
		export MOZ_ENABLE_PGSQL=1
		export MOZ_PGSQL_INCLUDES=/usr/include
		export MOZ_PGSQL_LIBS=/usr/$(get_libdir)
	fi
	mozconfig_use_enable mozcalendar calendar
	mozconfig_use_enable ldap
	mozconfig_use_enable ldap ldap-experimental
	mozconfig_use_enable mozsvg svg
	mozconfig_use_enable mozsvg svg-renderer-cairo
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}
	mozconfig_annotate '' --with-user-appdir=.mozilla

	if use moznomail && ! use mozcalendar; then
		mozconfig_annotate "+moznomail -mozcalendar" --disable-mailnews
	fi
	if use moznocompose && use moznomail; then
		mozconfig_annotate "+moznocompose +moznomail" --disable-composer
	fi

	# Finalize and report settings
	mozconfig_final

	# hardened GCC uses -fstack-protector-all by default, which breaks us
	has_hardened && append-flags -fno-stack-protector-all
	replace-flags -fstack-protector-all -fstack-protector

	####################################
	#
	#  Configure and build
	#
	####################################

	CPPFLAGS="${CPPFLAGS} -DARON_WAS_HERE" \
	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" \
	econf || die

	# It would be great if we could pass these in via CPPFLAGS or CFLAGS prior
	# to econf, but the quotes cause configure to fail.
	grep -Flre -DARON_WAS_HERE --exclude=config.\* . | xargs sed -i -e \
	's|-DARON_WAS_HERE|-DGENTOO_NSPLUGINS_DIR=\\\"/usr/'"$(get_libdir)"'/nsplugins\\\" -DGENTOO_NSBROWSER_PLUGINS_DIR=\\\"/usr/'"$(get_libdir)"'/nsbrowser/plugins\\\"|'

	# This removes extraneous CFLAGS from the Makefiles to reduce RAM
	# requirements while compiling
	edit_makefiles

	emake || die

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
	#  Build Enigmail extension
	#
	####################################

	if use crypt && ! use moznomail; then
		for x in ipc enigmail; do
			emake -C ${S}/extensions/${x} || die "emake ${x} failed"
		done
	fi
}

src_install() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	# Most of the installation happens here
	dodir ${MOZILLA_FIVE_HOME}
	cp -RL ${S}/dist/bin/* ${D}${MOZILLA_FIVE_HOME}

	# Create directory structure to support portage-installed extensions.
	# See update_chrome() in mozilla-launcher
	keepdir ${MOZILLA_FIVE_HOME}/chrome.d
	keepdir ${MOZILLA_FIVE_HOME}/extensions.d
	cp ${D}${MOZILLA_FIVE_HOME}/chrome/installed-chrome.txt \
		${D}${MOZILLA_FIVE_HOME}/chrome.d/0_base-chrome.txt

	# Create /usr/bin/mozilla
	install_mozilla_launcher_stub mozilla ${MOZILLA_FIVE_HOME}

	# Install icon and .desktop for menu entry
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/icon/mozilla-icon.png

	# Fix bug 54179: Install .desktop file into /usr/share/applications
	# instead of /usr/share/gnome/apps/Internet (18 Jun 2004 agriffis)
	insinto /usr/share/applications
	doins ${FILESDIR}/icon/mozilla.desktop

	# Fix icons to look the same everywhere
	insinto ${MOZILLA_FIVE_HOME}/icons
	doins ${S}/widget/src/gtk/mozicon16.xpm
	doins ${S}/widget/src/gtk/mozicon50.xpm

	####################################
	#
	# Install files necessary for applications to build against mozilla
	#
	####################################

	einfo "Installing includes and idl files..."
	dodir ${MOZILLA_FIVE_HOME}/include/idl /usr/include
	cd ${S}/dist
	cp -LfR include/* ${D}${MOZILLA_FIVE_HOME}/include
	cp -LfR idl/* ${D}${MOZILLA_FIVE_HOME}/include/idl

	# Install the NSS/SSL libs, headers and tools
	if use ssl; then
		einfo "Installing Mozilla NSS..."
		# Install the headers ('make install' do not work for headers ...)
		insinto ${MOZILLA_FIVE_HOME}/include/nss
		[ -d ${S}/dist/public/nss ] && doins ${S}/dist/public/nss/*.h
		[ -d ${S}/dist/public/seccmd ] && doins ${S}/dist/public/seccmd/*.h
		[ -d ${S}/dist/public/security ] && doins ${S}/dist/public/security/*.h
		# These come with zlib ...
		rm -f ${D}${MOZILLA_FIVE_HOME}/include/nss/{zconf.h,zlib.h}

		cd ${S}/security/nss

		mkdir -p ${WORKDIR}/nss/{bin,lib}
		export SOURCE_BIN_DIR=${WORKDIR}/nss/bin
		export SOURCE_LIB_DIR=${WORKDIR}/nss/lib

		make install || die "make failed"
		# Gets installed as symbolic links ...
		cp -Lf ${WORKDIR}/nss/bin/* ${D}/usr/bin
		cp -Lf ${WORKDIR}/nss/lib/* ${D}${MOZILLA_FIVE_HOME}

		# Need to unset these incase we want to rebuild, else the build
		# gets newked.
		unset SOURCE_LIB_DIR
		unset SOURCE_BIN_DIR
	fi

	# Fix mozilla-config and install it
	sed -i -e "s|/usr/lib/mozilla-${MY_PV}|${MOZILLA_FIVE_HOME}|g
		s|/usr/include/mozilla-${MY_PV}|${MOZILLA_FIVE_HOME}/include|g" \
		${S}/build/unix/mozilla-config
	exeinto ${MOZILLA_FIVE_HOME}
	doexe ${S}/build/unix/mozilla-config

	# Fix pkgconfig files and install them
	sed -i -e "s|-L/usr/lib/mozilla-${PV}|-L\$\{libdir\}|" \
			${S}/build/unix/mozilla-nspr.pc
	insinto /usr/$(get_libdir)/pkgconfig
	for x in ${S}/build/unix/*.pc; do
		sed -i -e "s|^libdir=.*|libdir=${MOZILLA_FIVE_HOME}|
			s|^includedir=.*|includedir=${MOZILLA_FIVE_HOME}/include|
			s|\(^Libs: -L.*\)\($\)|\1 -Wl,-R\$\{libdir\}\2|" ${x}
		doins ${x}
	done

	# Install rebuild script since mozilla-bin doesn't support registration yet
	exeinto ${MOZILLA_FIVE_HOME}
	doexe ${FILESDIR}/mozilla-rebuild-databases.pl

	# Install docs
	dodoc LEGAL LICENSE

	# Update Google search plugin to use UTF8 charset ...
	insinto ${MOZILLA_FIVE_HOME}/searchplugins
	doins ${FILESDIR}/google.src
}

pkg_preinst() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	# Remove entire installed instance to solve various problems,
	# for example see bug 27719
	rm -rf ${ROOT}${MOZILLA_FIVE_HOME}
}

pkg_postinst() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	# Update the component registry
	MOZILLA_LIBDIR=${ROOT}${MOZILLA_FIVE_HOME} MOZILLA_LAUNCHER=mozilla \
		/usr/libexec/mozilla-launcher -register

	# This should be called in the postinst and postrm of all the
	# mozilla, mozilla-bin, firefox, firefox-bin, thunderbird and
	# thunderbird-bin ebuilds.
	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	# Update the component registry
	if [[ -x ${MOZILLA_FIVE_HOME}/mozilla-bin ]]; then
		MOZILLA_LIBDIR=${ROOT}${MOZILLA_FIVE_HOME} MOZILLA_LAUNCHER=mozilla \
			/usr/libexec/mozilla-launcher -register
	fi

	update_mozilla_launcher_symlinks
}
