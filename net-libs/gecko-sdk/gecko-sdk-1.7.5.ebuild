# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gecko-sdk/gecko-sdk-1.7.5.ebuild,v 1.3 2005/03/23 16:18:40 seemant Exp $

unset ALLOWED_FLAGS  # stupid extra-functions.sh ... bug 49179
inherit flag-o-matic gcc eutils nsplugins mozilla-launcher mozconfig makeedit

IUSE=""

EMVER="0.89.6"
IPCVER="1.1.2"

# handle _rc versions
MY_PV=${PV/_alpha/a} 	# handle alpha
MY_PV=${MY_PV/_beta/b}	# handle beta
MY_PV=${MY_PV/_rc/rc}	# handle rc

DESCRIPTION="Mozilla Application Suite - web browser, email, HTML editor, IRC"
HOMEPAGE="http://www.mozilla.org"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/mozilla/releases/mozilla${MY_PV}/source/mozilla-source-${MY_PV}.tar.bz2"

KEYWORDS="x86 ppc amd64"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"

# xrender.pc appeared for the first time in xorg-x11-6.7.0-r2
# and is required to build with support for cairo.  #71504
RDEPEND="
	mozsvg? (
		>=x11-base/xorg-x11-6.7.0-r2
		x11-libs/cairo
	)"

DEPEND="${RDEPEND}
	dev-lang/perl"

S="${WORKDIR}/mozilla"

src_unpack() {
	typeset x

	unpack ${A} || die "unpack failed"
	cd ${S} || die "cd failed"

	if [[ $(gcc-major-version) -eq 3 ]]; then
		# ABI Patch for alpha/xpcom for gcc-3.x
		if [[ ${ARCH} == alpha ]]; then
			epatch ${PORTDIR}/www-client/mozilla/files/mozilla-alpha-xpcom-subs-fix.patch
		fi
	fi

	# Fix stack growth logic
	epatch ${PORTDIR}/www-client/mozilla/files/mozilla-${PV}-stackgrowth.patch

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

	# Patch for newer versions of cairo ( bug #80301) 
	if has_version '>=x11-libs/cairo-0.3.0'; then
		epatch ${FILESDIR}/svg-cairo-0.3.0-fix.patch
	fi

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
}

src_install() {
	cd ${S}/dist
	mkdir -p ${D}/usr/share
	cp -RL sdk ${D}/usr/share/gecko-sdk
}
