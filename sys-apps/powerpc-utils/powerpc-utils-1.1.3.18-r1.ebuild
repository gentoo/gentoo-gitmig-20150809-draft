# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/powerpc-utils/powerpc-utils-1.1.3.18-r1.ebuild,v 1.2 2009/04/17 14:47:46 ranger Exp $

inherit eutils versionator

BASEVER=$(get_version_component_range 1-3)
DEBREV=$(get_version_component_range 4)

DESCRIPTION="PowerPC utilities including nvsetenv, and additional OldWorld apps"
SRC_URI="http://http.us.debian.org/debian/pool/main/p/powerpc-utils/${PN}_${BASEVER}.orig.tar.gz
	http://http.us.debian.org/debian/pool/main/p/powerpc-utils/${PN}_${BASEVER}-${DEBREV}.diff.gz
	mirror://gentoo/${PN}-cleanup.patch.bz2"

HOMEPAGE="http://http.us.debian.org/debian/pool/main/p/powerpc-utils/"
KEYWORDS="-* ppc ppc64"
IUSE=""
DEPEND="virtual/libc"
RDEPEND=""
SLOT="0"
LICENSE="GPL-2"

S="${WORKDIR}/pmac-utils"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${PN}_${BASEVER}-${DEBREV}.diff
	epatch ${WORKDIR}/${PN}-cleanup.patch
}

src_compile() {
	emake CFLAGS="$CFLAGS -fsigned-char -D_GNU_SOURCE" || die
}

src_install() {
	into /usr
	dosbin autoboot backlight bootsched clock fblevel fdeject fnset
	dosbin macos mousemode nvsetenv nvsetvol nvvideo sndvolmix trackpad
	doman autoboot.8 bootsched.8 clock.8 fblevel.8 fdeject.8 macos.8
	doman mousemode.8 nvsetenv.8 nvsetvol.8 nvvideo.8 sndvolmix.8 trackpad.8

	ewarn "The lsprop utility has been moved into the ibm-powerpc-utils package."
}
