# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tkzinc/tkzinc-3.2.100.ebuild,v 1.2 2004/08/30 23:38:07 dholm Exp $

inherit eutils

DESCRIPTION="A Tk widget library."
HOMEPAGE="http://www.tkzinc.org"
SRC_URI="http://www.tkzinc.org/Packages/zinc-tk_${PV}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="threads opengl doc"
DEPEND=">=dev-lang/tk-8.4
	opengl? ( virtual/opengl )
	doc? ( virtual/tetex )"

S=${WORKDIR}/Tkzinc

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/without-opengl.patch
	epatch ${FILESDIR}/fix-makefile.patch
}

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
	make DESTDIR=${D} install || die "make install failed"

	dodoc BUGS README
	use doc && dodoc doc/refman.pdf
}
