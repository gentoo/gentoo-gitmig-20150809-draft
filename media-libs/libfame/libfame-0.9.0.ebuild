# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libfame/libfame-0.9.0.ebuild,v 1.21 2005/01/04 10:01:36 hardave Exp $

inherit flag-o-matic gnuconfig

DESCRIPTION="MPEG-1 and MPEG-4 video encoding library"
HOMEPAGE="http://fame.sourceforge.net/"
SRC_URI="mirror://sourceforge/fame/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc sparc x86"
IUSE="mmx sse"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die

	# This is needed for alpha and probably other newer arches
	# (13 Jan 2004 agriffis)
	gnuconfig_update

	[[ "${ARCH}" == "amd64" ]] && libtoolize -c -f
}

src_compile() {
	filter-flags -fprefetch-loop-arrays
	econf $(use_enable mmx) $(use_enable sse) || die
	emake || die
}

src_install() {
	dodir /usr
	dodir /usr/lib

	einstall install || die
	dobin libfame-config

	insinto /usr/share/aclocal
	doins libfame.m4

	dodoc CHANGES README
	doman doc/*.3
}
