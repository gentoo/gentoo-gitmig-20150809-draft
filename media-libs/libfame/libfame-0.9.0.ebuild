# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libfame/libfame-0.9.0.ebuild,v 1.15 2004/01/29 04:08:25 agriffis Exp $

inherit flag-o-matic gnuconfig

S=${WORKDIR}/${P}
DESCRIPTION="MPEG-1 and MPEG-4 video encoding library"
SRC_URI="mirror://sourceforge/fame/${P}.tar.gz"
HOMEPAGE="http://fame.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64"

DEPEND="virtual/glibc"

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
