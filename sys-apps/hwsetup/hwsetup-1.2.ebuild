# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwsetup/hwsetup-1.2.ebuild,v 1.1 2007/01/05 19:44:46 wolf31o2 Exp $

inherit eutils toolchain-funcs

MY_PV=${PV}-3
DESCRIPTION="Hardware setup program from Knoppix - used only on LiveCD"
HOMEPAGE="http://www.knopper.net/"
SRC_URI="http://debian-knoppix.alioth.debian.org/sources/${PN}_${MY_PV}.tar.gz"
#http://developer.linuxtag.net/knoppix/sources/${PN}_${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 -mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="sys-libs/libkudzu
	sys-apps/pciutils"
RDEPEND="${DEPEND}
	sys-apps/hwdata-gentoo"

src_unpack() {
	unpack ${A}
	epatch \
		"${FILESDIR}"/${P}-dyn_blacklist.patch \
		"${FILESDIR}"/${P}-fastprobe.patch \
		"${FILESDIR}"/${P}-gentoo.patch
}

src_compile() {
	emake LDFLAGS="-s ${LDFLAGS}" OPT="${CFLAGS}" CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	einstall DESTDIR="${D}" PREFIX=/usr MANDIR=/usr/share/man || die "Install failed"
}

pkg_postinst() {
	ewarn "This package is intended for usage on the Gentoo release media.  If"
	ewarn "you are not building a CD, remove this package.  It will not work"
	ewarn "properly on a running system, as Gentoo does not use any of the"
	ewarn "Knoppix-style detection except for CD builds."
}
