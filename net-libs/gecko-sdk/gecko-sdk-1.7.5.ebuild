# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gecko-sdk/gecko-sdk-1.7.5.ebuild,v 1.8 2005/06/27 23:38:53 swegener Exp $

unset ALLOWED_FLAGS  # stupid extra-functions.sh ... bug 49179
inherit flag-o-matic toolchain-funcs eutils nsplugins mozilla-launcher mozconfig makeedit multilib

IUSE="java crypt ssl moznomail postgres mozsvg"

EMVER="0.91.0"
IPCVER="1.1.3"
MOZVER="1.7.8"

# handle _rc versions
MY_PV=${MOZVER/_alpha/a} 	# handle alpha
MY_PV=${MY_PV/_beta/b}	# handle beta
MY_PV=${MY_PV/_rc/rc}	# handle rc

DESCRIPTION="Gecko SDK for building applications based on Gecko"
HOMEPAGE="http://www.mozilla.org"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/mozilla/releases/mozilla${MY_PV}/source/mozilla-${MY_PV}-source.tar.bz2
	crypt? ( !moznomail? (
		http://www.mozilla-enigmail.org/downloads/src/ipc-${IPCVER}.tar.gz
		http://www.mozilla-enigmail.org/downloads/src/enigmail-${EMVER}.tar.gz
	) )"

KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"

# xrender.pc appeared for the first time in xorg-x11-6.7.0-r2
# and is required to build with support for cairo.  #71504
RDEPEND="java? ( virtual/jre )
	mozsvg? (
		>=x11-base/xorg-x11-6.7.0-r2
		x11-libs/cairo
	)
	crypt? ( !moznomail? ( >=app-crypt/gnupg-1.2.1 ) )
	>=www-client/mozilla-launcher-1.28"

DEPEND="${RDEPEND}
	~sys-devel/autoconf-2.13
	java? ( >=dev-java/java-config-0.2.0 )
	dev-lang/perl
	postgres? ( >=dev-db/postgresql-7.2.0 )"

S="${WORKDIR}/mozilla"

src_unpack() {
	typeset x

	unpack ${A} || die "unpack failed"
	cd ${S} || die "cd failed"

	if ! [[ $(gcc-major-version) -eq 2 ]]; then
		# ABI Patch for alpha/xpcom for gcc-3.x
		if [[ ${ARCH} == alpha ]]; then
			epatch ${PORTDIR}/www-client/mozilla/files/mozilla-alpha-xpcom-subs-fix.patch
		fi
	fi

	# Fix stack growth logic
	epatch ${PORTDIR}/www-client/mozilla/files/mozilla-stackgrowth.patch

	# Fix logic error when using RAW target
	# <azarah@gentoo.org> (23 Feb 2003)
	epatch ${PORTDIR}/www-client/mozilla/files/1.3/mozilla-1.3-fix-RAW-target.patch

	# HPPA patches from Ivar <orskaug@stud.ntnu.no>
	# <gmsoft@gentoo.org> (22 Dec 2004)
	epatch ${PORTDIR}/www-client/mozilla/files/mozilla-hppa.patch

	# patch out ft caching code since the API changed between releases of
	# freetype; this enables freetype-2.1.8+ compat.
	# https://bugzilla.mozilla.org/show_bug.cgi?id=234035#c65
	epatch ${PORTDIR}/www-client/mozilla/files/mozilla-1.7.3-4ft2.patch

	# Patch to allow compilation on ppc64 - bug #54843
	use ppc64 && epatch ${PORTDIR}/www-client/mozilla/files/mozilla-1.7.6-ppc64.patch

	# Patch for newer versions of cairo ( bug #80301)
	if has_version '>=x11-libs/cairo-0.3.0'; then
		epatch ${PORTDIR}/www-client/mozilla/files/svg-cairo-0.3.0-fix.patch
	fi

	# Fix building with gcc4
	epatch ${PORTDIR}/www-client/mozilla/files/mozilla-1.7.6-gcc4.patch

	# Mozilla Bug 292257, https://bugzilla.mozilla.org/show_bug.cgi?id=292257
	# Mozilla crashes under some rare cases when plugin.default_plugin_disabled
	# is true. This patch fixes that. Backported by hansmi@gentoo.org.
	epatch ${PORTDIR}/www-client/mozilla/files/mozilla-${MOZVER}-objectframefix.diff

	# Fix building on amd64 with gcc4 (patch from Debian)
	epatch ${PORTDIR}/www-client/mozilla/files/mozilla-${MOZVER}-amd64.patch

	# Fix scripts that call for /usr/local/bin/perl #51916
	ebegin "Patching smime to call perl from /usr/bin"
	sed -i -e '1s,usr/local/bin,usr/bin,' security/nss/cmd/smimetools/smime
	eend || die "sed failed"

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
	mozconfig_use_extension postgres sql
	mozconfig_use_enable mozcalendar calendar
	mozconfig_use_enable ldap
	mozconfig_use_enable ldap ldap-experimental
	mozconfig_use_enable mozsvg svg
	mozconfig_use_enable mozsvg svg-renderer-cairo
	mozconfig_annotate '' --prefix=/usr/$(get_libdir)/mozilla
	mozconfig_annotate '' --with-default-mozilla-five-home=/usr/$(get_libdir)/mozilla

	if use moznomail && ! use mozcalendar; then
		mozconfig_annotate "+moznomail -mozcalendar" --disable-mailnews
	fi
	if use moznocompose && use moznomail; then
		mozconfig_annotate "+moznocompose +moznomail" --disable-composer
	fi

	# Finalize and report settings
	mozconfig_final

	if use postgres ; then
		export MOZ_ENABLE_PGSQL=1
		export MOZ_PGSQL_INCLUDES=/usr/include
		export MOZ_PGSQL_LIBS=/usr/$(get_libdir)
	fi

	####################################
	#
	#  Configure and build Mozilla
	#
	####################################

	# ./configure picks up the mozconfig stuff
	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" \
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
	cd ${S}/dist
	mkdir -p ${D}/usr/share
	cp -RL sdk ${D}/usr/share/gecko-sdk
}
