# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/TkZinc/TkZinc-3.2.100.ebuild,v 1.2 2004/08/08 14:52:54 cardoe Exp $

inherit eutils

DESCRIPTION="A Tk widget library."
HOMEPAGE="http://www.tkzinc.org"
SRC_URI="http://www.tkzinc.org/Packages/zinc-tk_${PV}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="threads opengl doc"
DEPEND=">=dev-lang/tk-8.4
	opengl? ( virtual/opengl )
	doc? ( virtual/tetex )"

S=${WORKDIR}/Tkzinc

src_compile() {
	epatch ${FILESDIR}/without-opengl.patch
	epatch ${FILESDIR}/fix-makefile.patch

	local myconf
	if use opengl ; then
		myconf="--enable-gl=damage"
	fi

	econf \
		`use_enable threads` \
		${myconf} || die
#		--with-tcl=/usr/lib --with-tk=/usr/lib \

	emake || die "make failed"
	use doc && make pdf
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc BUGS Copyright README
	use doc && dodoc doc/refman.pdf
}
