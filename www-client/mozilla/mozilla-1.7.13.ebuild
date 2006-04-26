# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/mozilla/mozilla-1.7.13.ebuild,v 1.6 2006/04/26 14:18:47 gmsoft Exp $

unset ALLOWED_FLAGS  # Stupid extra-functions.sh ... bug 49179
MOZ_FREETYPE2="no"   # Need to disable for newer .. remove here and in mozconfig
	                 # when older is removed from tree.
MOZ_PANGO="yes"      # Need to enable for newer .. remove here and in mozconfig
	                 # when older is removed from tree.
inherit flag-o-matic toolchain-funcs eutils mozconfig mozilla-launcher makeedit multilib

PVER="1.0"
EMVER="0.92.0"
IPCVER="1.1.3"
SVGVER="2.3.10p1"

# handle _rc versions
MY_PV=${PV/_alpha/a} 	# handle alpha
MY_PV=${MY_PV/_beta/b}	# handle beta
MY_PV=${MY_PV/_rc/rc}	# handle rc

DESCRIPTION="Mozilla Application Suite - web browser, email, HTML editor, IRC"
HOMEPAGE="http://www.mozilla.org"
SRC_URI="http://ftp.${PN}.org/pub/${PN}.org/${PN}/releases/${PN}${MY_PV}/source/${PN}-${MY_PV}-source.tar.bz2
	crypt? ( !moznomail? (
		http://www.${PN}-enigmail.org/downloads/src/ipc-${IPCVER}.tar.gz
		http://www.${PN}-enigmail.org/downloads/src/enigmail-${EMVER}.tar.gz
	) )
	mozsvg? (
		mirror://gentoo/moz_libart_lgpl-${SVGVER}.tar.bz2
		http://dev.gentoo.org/~azarah/${PN}/moz_libart_lgpl-${SVGVER}.tar.bz2
	)
	mirror://gentoo/${P}-patches-${PVER}.tar.bz2
	http://dev.gentoo.org/~anarchy/dist/${P}-patches-${PVER}.tar.bz2"

KEYWORDS="alpha amd64 hppa ~ia64 ppc ~ppc64 sparc x86"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"
IUSE="crypt gnome java ldap mozcalendar mozdevelop moznocompose moznoirc moznomail mozsvg postgres ssl"

# xrender.pc appeared for the first time in xorg-x11-6.7.0-r2
# and is required to build with support for cairo.  #71504
RDEPEND="java? ( virtual/jre )
	mozsvg? ( !<x11-base/xorg-x11-6.7.0-r2 )
	crypt? ( !moznomail? ( >=app-crypt/gnupg-1.2.1 ) )
	>=www-client/mozilla-launcher-1.42"

DEPEND="${RDEPEND}
	~sys-devel/autoconf-2.13
	java? ( >=dev-java/java-config-0.2.0 )
	dev-lang/perl
	postgres? ( >=dev-db/postgresql-7.2.0 )"

S=${WORKDIR}/${PN}

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
	unpack ${PN}-${MY_PV}-source.tar.bz2 ${P}-patches-${PVER}.tar.bz2
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
	if use mozsvg; then
		cd ${S}/other-licenses
		unpack moz_libart_lgpl-${SVGVER}.tar.bz2
	fi
	cd ${S}

	####################################
	#
	# patch collection
	#
	####################################

	# Firefox only patches
	rm -f ${WORKDIR}/patch/{093,094,402,407}*
	# Need pango-1.10.0 stable
	rm -f ${WORKDIR}/patch/03[67]*
	epatch ${WORKDIR}/patch

	# Without 03[67]* patches, we need to link to pangoxft
	epatch ${FILESDIR}/${PN}-1.7.12-gtk2xft-link-pangoxft.patch

	# Fix scripts that call for /usr/local/bin/perl #51916
	ebegin "Patching smime to call perl from /usr/bin"
	sed -i -e '1s,usr/local/bin,usr/bin,' ${S}/security/nss/cmd/smimetools/smime
	eend $? || die "sed failed"

	# Fix a compilation issue using the 32-bit userland with 64-bit kernel on
	# PowerPC, because with that configuration, mozilla detects a ppc64 system.
	# -- hansmi, 2005-10-02
	if use ppc && [[ "${PROFILE_ARCH}" == ppc64 ]]; then
		sed -i -e "s#OS_TEST=\`uname -m\`\$#OS_TEST=${ARCH}#" \
			${S}/configure.in
		sed -i -e "s#OS_TEST :=.*uname -m.*\$#OS_TEST:=${ARCH}#" \
			${S}/security/coreconf/arch.mk
	fi

	# Needed by some of the patches
	WANT_AUTOCONF=2.1 autoconf || die "WANT_AUTOCONF failed"
}

src_compile() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}
	declare x

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
	mozconfig_use_enable mozsvg svg-renderer-libart
	use mozsvg && export MOZ_INTERNAL_LIBART_LGPL=1
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
	sed -i -e \
		's|-DARON_WAS_HERE|-DGENTOO_NSPLUGINS_DIR=\\\"/usr/'"$(get_libdir)"'/nsplugins\\\" -DGENTOO_NSBROWSER_PLUGINS_DIR=\\\"/usr/'"$(get_libdir)"'/nsbrowser/plugins\\\"|' \
		${S}/config/autoconf.mk \
		${S}/nsprpub/config/autoconf.mk \
		${S}/xpfe/global/buildconfig.html

	# Fixup the RPATH
	sed -i -e \
		's|#RPATH_FIXER|'"${MOZILLA_FIVE_HOME}"'|' \
		${S}/config/rules.mk \
		${S}/nsprpub/config/rules.mk \
		${S}/security/coreconf/rules.mk \
		${S}/security/coreconf/rules.mk

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
	doins ${FILESDIR}/icon/${PN}-icon.png

	# Fix bug 54179: Install .desktop file into /usr/share/applications
	# instead of /usr/share/gnome/apps/Internet (18 Jun 2004 agriffis)
	insinto /usr/share/applications
	doins ${FILESDIR}/icon/${PN}.desktop

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
	dodir ${MOZILLA_FIVE_HOME}/{include,idl} /usr/include
	cd ${S}/dist
	cp -LfR include/* ${D}${MOZILLA_FIVE_HOME}/include
	cp -LfR idl/* ${D}${MOZILLA_FIVE_HOME}/idl

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
	sed -i -e "s|/usr/$(get_libdir)/${PN}-${MY_PV}|${MOZILLA_FIVE_HOME}|g
		s|/usr/include/${PN}-${MY_PV}|${MOZILLA_FIVE_HOME}/include|g
		s|/usr/share/idl/${PN}-${MY_PV}|${MOZILLA_FIVE_HOME}/idl|g
		s|\(echo -L.*\)\($\)|\1 -Wl,-rpath,${MOZILLA_FIVE_HOME}\2|" \
		${S}/build/unix/${PN}-config
	exeinto ${MOZILLA_FIVE_HOME}
	doexe ${S}/build/unix/${PN}-config

	# Fix pkgconfig files and install them
	insinto /usr/$(get_libdir)/pkgconfig
	for x in ${S}/build/unix/*.pc; do
		sed -i -e "s|^libdir=.*|libdir=${MOZILLA_FIVE_HOME}|
			s|^includedir=.*|includedir=${MOZILLA_FIVE_HOME}/include|
			s|^idldir=.*|idldir=${MOZILLA_FIVE_HOME}/idl|
			s|\(Libs:.*\)\($\)|\1 -Wl,-rpath,\${libdir}\2|" ${x}
		doins ${x}
	done

	# Install env.d snippet, which isn't necessary for running mozilla, but
	# might be necessary for programs linked against firefox
	insinto /etc/env.d
	doins ${FILESDIR}/10${PN}
	dosed "s|/usr/lib|/usr/$(get_libdir)|" /etc/env.d/10${PN}

	# Install rebuild script since mozilla-bin doesn't support registration yet
	exeinto ${MOZILLA_FIVE_HOME}
	doexe ${FILESDIR}/${PN}-rebuild-databases.pl
	dosed -e 's|/lib/|/'"$(get_libdir)"'/|g' \
		${MOZILLA_FIVE_HOME}/${PN}-rebuild-databases.pl

	# Install docs
	dodoc ${S}/{LEGAL,LICENSE}

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
	MOZILLA_LIBDIR=${ROOT}${MOZILLA_FIVE_HOME} MOZILLA_LAUNCHER=${PN} \
		/usr/libexec/mozilla-launcher -register

	# This should be called in the postinst and postrm of all the
	# mozilla, mozilla-bin, firefox, firefox-bin, thunderbird and
	# thunderbird-bin ebuilds.
	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	# Update the component registry
	if [[ -x ${MOZILLA_FIVE_HOME}/${PN}-bin ]]; then
		MOZILLA_LIBDIR=${ROOT}${MOZILLA_FIVE_HOME} MOZILLA_LAUNCHER=${PN} \
			/usr/libexec/mozilla-launcher -register
	fi

	update_mozilla_launcher_symlinks
}
