# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/abakus/abakus-0.90.ebuild,v 1.4 2006/04/30 17:10:37 centic Exp $

inherit kde

DESCRIPTION="Abakus is a simple calculator for kde, similar to bc with a nice gui."
HOMEPAGE="http://grammarian.homelinux.net/abakus/"
#SRC_URI="http://grammarian.homelinux.net/abakus/${P}.tar.bz2"
SRC_URI="http://www.kde-apps.org/content/files/16751-abakus-0.90.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
# leave gmp out for now, does not work for me
IUSE="debug" # gmp

DEPEND=">=dev-util/scons-0.96.1
		gmp? ( dev-libs/mpfr )"
#RDEPEND=""

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
	dodoc AUTHORS COPYING README
}

