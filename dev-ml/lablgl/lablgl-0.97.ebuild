# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/lablgl/lablgl-0.97.ebuild,v 1.8 2004/02/18 12:53:05 mattam Exp $

IUSE=""

DESCRIPTION="Objective CAML interface for OpenGL"
HOMEPAGE="http://wwwfun.kurims.kyoto-u.ac.jp/soft/olabl/lablgl.html"
LICENSE="as-is"

DEPEND=">=dev-lang/ocaml-3.04
	virtual/opengl"

SRC_URI="http://wwwfun.kurims.kyoto-u.ac.jp/soft/olabl/dist/${P}.tar.gz"
S=${WORKDIR}/lablGL-${PV}
SLOT="0"
KEYWORDS="x86"

#need to do some mangling to keep ebuild name lowercase
#(anyway package uses mixture of upper and lower case letters)
Name="LablGL"

src_unpack() {

	unpack ${A}

	# patch the makefile to include DESTDIR support
	cd ${S} || die
	patch -p0 < ${FILESDIR}/${Name}-${PV}-Makefile-destdir.patch || die
}

src_compile() {

	# make configuration file
	cp ${FILESDIR}/${Name}-${PV}-Makefile.config ${S}/Makefile.config || die

	# build
	make all opt || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc README CHANGES COPYRIGHT
}
