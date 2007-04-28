# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tkzinc/tkzinc-3.3.4.ebuild,v 1.1 2007/04/28 00:12:47 matsuu Exp $

inherit eutils

DESCRIPTION="A Tk widget library."
HOMEPAGE="http://www.tkzinc.org"
SRC_URI="http://www.tkzinc.org/Packages/zinc-tk_${PV}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE="threads opengl doc"
DEPEND=">=dev-lang/tk-8.4
	opengl? ( virtual/opengl )
	doc? ( virtual/tetex )"

S="${WORKDIR}/Tkzinc"

src_compile() {
	local myconf
	if use opengl ; then
		myconf="--enable-gl=damage"
	fi

	econf \
		$(use_enable threads) \
		${myconf} || die

	emake || die "make failed"
	if use doc ; then
		make pdf || die "make pdf files failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc BUGS README
	dohtml -r doc/*
	use doc && dodoc doc/refman.pdf
}
