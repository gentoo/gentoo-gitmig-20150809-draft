# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gecko-sdk/gecko-sdk-1.7.3.ebuild,v 1.1 2004/10/23 13:57:10 josejx Exp $

unset ALLOWED_FLAGS  # stupid extra-functions.sh ... bug 49179
inherit flag-o-matic gcc eutils nsplugins mozilla-launcher mozilla makeedit

IUSE="java crypt gtk2 ssl"
# Internal USE flags that I do not really want to advertise ...
IUSE="${IUSE} mozcalendar moznoirc moznomail moznocompose moznoxft"

EMVER="0.86.0"
IPCVER="1.0.8"

# handle _rc versions
MY_PV=${PV/_alpha/a} 	# handle alpha
MY_PV=${MY_PV/_beta/b}	# handle beta
MY_PV=${MY_PV/_rc/rc}	# handle rc

DESCRIPTION="Gecko SDK"
HOMEPAGE="http://www.mozilla.org"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/mozilla/releases/mozilla${MY_PV}/src/mozilla-source-${MY_PV}.tar.bz2"
KEYWORDS="ppc"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"
RDEPEND=""
DEPEND="java? ( >=dev-java/java-config-0.2.0 )
	dev-lang/perl"

S="${WORKDIR}/mozilla"

src_unpack() {
	typeset x

	unpack ${A} || die "unpack failed"
	cd ${S} || die

	if [[ $(gcc-major-version) -eq 3 ]]; then
		# ABI Patch for alpha/xpcom for gcc-3.x
		if [[ ${ARCH} == alpha ]]; then
			epatch ${FILESDIR}/mozilla-alpha-xpcom-subs-fix.patch
		fi
	fi

	# Fix logic error when using RAW target
	# <azarah@gentoo.org> (23 Feb 2003)
	epatch ${FILESDIR}/mozilla-1.3-fix-RAW-target.patch

	WANT_AUTOCONF=2.1 autoconf || die
}

src_compile() {
	local myconf

	####################################
	#
	# myconf, CFLAGS and CXXFLAGS setup
	#
	####################################

	# mozilla_conf comes from mozilla.eclass
	mozilla_conf

	myconf="${myconf} \
		--prefix=/usr/lib/mozilla \
		--with-default-mozilla-five-home=/usr/lib/mozilla"

	####################################
	#
	#  Configure and build Mozilla
	#
	####################################

	./configure ${myconf} || die

	# This removes extraneous CFLAGS from the Makefiles to reduce RAM
	# requirements while compiling
	edit_makefiles

	emake || die
}

src_install(){
	cd ${S}/dist
	mkdir -p ${D}/usr/share
	cp -RL sdk ${D}/usr/share/gecko-sdk
}
