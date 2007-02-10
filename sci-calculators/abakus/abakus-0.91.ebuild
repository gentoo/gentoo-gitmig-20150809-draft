# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/abakus/abakus-0.91.ebuild,v 1.4 2007/02/10 13:24:57 troll Exp $

inherit kde

DESCRIPTION="Abakus is a simple calculator for kde, similar to bc with a nice gui."
HOMEPAGE="http://grammarian.homelinux.net/abakus/"
SRC_URI="http://www.kde-apps.org/content/files/16751-${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
# leave gmp out for now, does not work for me
IUSE="debug gmp"

RDEPEND="gmp? ( dev-libs/mpfr )"
DEPEND="${RDEPEND}
		>=dev-util/scons-0.96.1"

need-kde 3.3

src_compile() {
	local myconf="kdeincludes=$(kde-config --prefix)/include prefix=/usr"
	use amd64 && myconf="${myconf} libsuffix=64"
	use debug && myconf="${myconf} debug=full"

#	use gmp && myconf="${myconf} mpfr=yes"
#	use gmp || myconf="${myconf} mpfr=no"

	einfo "Calling configure with: ${myconf}"

	scons configure ${myconf} || die "configure failed"
	scons ${MAKEOPTS} || die "scons failed"
}

src_install() {
	DESTDIR="${D}/usr" scons install
	dodoc AUTHORS README

	rm -fR ${D}/usr/share/applnk/
	newicon ${S}/src/hi64-app-abakus.png ${PN}.png
	domenu ${S}/src/${PN}.desktop
}
