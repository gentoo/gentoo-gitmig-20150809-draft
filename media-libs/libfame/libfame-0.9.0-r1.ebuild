# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libfame/libfame-0.9.0-r1.ebuild,v 1.2 2004/02/24 08:33:13 mr_bones_ Exp $

inherit flag-o-matic gnuconfig

S="${WORKDIR}/${P}"
DESCRIPTION="MPEG-1 and MPEG-4 video encoding library"
SRC_URI="mirror://sourceforge/fame/${P}.tar.gz"
HOMEPAGE="http://fame.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Do not add -march=i586, bug #41770.
	sed -i -e 's:-march=i[345]86 ::g' configure

	# This is needed for alpha and probably other newer arches (amd64)
	# (13 Jan 2004 agriffis)
	gnuconfig_update
}

src_compile() {
#	filter-flags -fprefetch-loop-arrays
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
