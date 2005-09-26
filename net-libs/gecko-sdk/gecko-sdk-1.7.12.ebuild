# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gecko-sdk/gecko-sdk-1.7.12.ebuild,v 1.1 2005/09/26 01:01:15 azarah Exp $

unset ALLOWED_FLAGS  # Stupid extra-functions.sh ... bug 49179
MOZ_FREETYPE2="no"   # Need to disable for newer .. remove here and in mozconfig
	                 # when older is removed from tree.
inherit flag-o-matic toolchain-funcs eutils mozconfig mozilla-launcher makeedit multilib

SVGVER="2.3.10p1"

# handle _rc versions
MY_PV=${PV/_alpha/a} 	# handle alpha
MY_PV=${MY_PV/_beta/b}	# handle beta
MY_PV=${MY_PV/_rc/rc}	# handle rc

DESCRIPTION="Mozilla Application Suite - web browser, email, HTML editor, IRC"
HOMEPAGE="http://www.mozilla.org"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/mozilla/releases/mozilla${MY_PV}/source/mozilla-${MY_PV}-source.tar.bz2
	mozsvg? (
		mirror://gentoo/moz_libart_lgpl-${SVGVER}.tar.bz2
		http://dev.gentoo.org/~azarah/mozilla/moz_libart_lgpl-${SVGVER}.tar.bz2
	)
	mirror://gentoo/mozilla-jslibmath-alpha.patch
	mirror://gentoo/mozilla-1.7.12-gtk2xft.patch.bz2
	http://dev.gentoo.org/~azarah/mozilla/mozilla-1.7.12-gtk2xft.patch.bz2
	http://dev.gentoo.org/~agriffis/dist/mozilla-1.7.10-nsplugins-v2.patch"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
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

S=${WORKDIR}/mozilla


src_unpack() {
	unpack mozilla-${MY_PV}-source.tar.bz2
	cd ${S} || die

	if use mozsvg; then
		cd ${S}/other-licenses
		unpack moz_libart_lgpl-${SVGVER}.tar.bz2
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
			epatch ${FILESDIR}/mozilla-alpha-xpcom-subs-fix.patch
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
	epatch ${FILESDIR}/mozilla-1.7.8-amd64.patch

	####################################
	#
	# general compilation and run-time fixes
	#
	####################################

	# GCC4 compile fix, bug #87800
	epatch ${FILESDIR}/mozilla-1.7.6-gcc4.patch

	# Fix stack growth logic
	epatch ${FILESDIR}/mozilla-stackgrowth.patch

	# Rather use gtk2+xft than freetype for font rendering, and add patch
	# from mozilla bugzilla to improve printing.
	# https://bugzilla.mozilla.org/show_bug.cgi?id=215219#c113
	epatch ${DISTDIR}/mozilla-1.7.12-gtk2xft.patch.bz2
	# Fix for above
	epatch ${FILESDIR}/mozilla-1.7.12-gtk2xft-link-pangoxft.patch

	# Fix libart SVG renderer building against newer freetype2
	epatch ${FILESDIR}/mozilla-1.7.12-libart-freetype.patch

	####################################
	#
	# behavioral fixes
	#
	####################################

	# Mozilla Bug 292257, https://bugzilla.mozilla.org/show_bug.cgi?id=292257
	# Mozilla crashes under some rare cases when plugin.default_plugin_disabled
	# is true. This patch fixes that. Backported by hansmi@gentoo.org.
	epatch ${FILESDIR}/mozilla-1.7.8-objectframefix.diff

	# Fix scripts that call for /usr/local/bin/perl #51916
	ebegin "Patching smime to call perl from /usr/bin"
	sed -i -e '1s,usr/local/bin,usr/bin,' security/nss/cmd/smimetools/smime
	eend $? || die "sed failed"

	# look in /usr/lib/nsplugins for plugins, in addition to the usual places
	epatch ${DISTDIR}/mozilla-1.7.10-nsplugins-v2.patch

	####################################
	#
	# security fixes
	#
	####################################

	# Needed by some of the patches
	WANT_AUTOCONF=2.1 autoconf || die "WANT_AUTOCONF failed"
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

	# This removes extraneous CFLAGS from the Makefiles to reduce RAM
	# requirements while compiling
	edit_makefiles

	emake || die
}

src_install() {
	cd ${S}/dist
	mkdir -p ${D}/usr/$(get_libdir)
	cp -RL sdk ${D}/usr/$(get_libdir)/gecko-sdk
}
