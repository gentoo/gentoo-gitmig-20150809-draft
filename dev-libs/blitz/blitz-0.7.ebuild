# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/blitz/blitz-0.7.ebuild,v 1.8 2004/11/20 00:50:53 dragonheart Exp $

inherit base

S=${WORKDIR}/Blitz++-${PV}
DESCRIPTION="High-performance C++ numeric library"
SRC_URI="mirror://sourceforge/${PN/-/}/Blitz++-${PV}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://www.oonumerics.org/blitz"
DEPEND="virtual/tetex
	icc? ( dev-lang/icc )"
IUSE="icc"

SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="GPL-2"

PATCHES1=${FILESDIR}/blitz-0.7.diff

src_compile() {
	local myconf
	# ICC: if we've got it, use it
	use icc && myconf="--with-cxx=icc" || myconf="--with-cxx=gcc"

	econf ${myconf} || die "econf failed"
	emake lib || die
}

src_install () {

	einstall docdir=${D}/usr/share/doc/${P} || die
	dodoc ChangeLog ChangeLog.1 LICENSE README README.binutils \
	      TODO COPYING LEGAL AUTHORS NEWS
}
