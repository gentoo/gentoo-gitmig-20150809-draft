# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/gauche-gl/gauche-gl-0.1.3.ebuild,v 1.1 2002/07/19 23:16:45 karltk Exp $

DESCRIPTION="OpenGL 1.1 bindings for Gauche"
HOMEPAGE="http://gauche.sf.net"
SRC_URI="mirror://sourceforge/gauche/Gauche-gl-${PV}.tgz"
LICENSE="BSD"
SLOT="0.1"
KEYWORDS="x86"
DEPEND="virtual/glibc
	virtual/opengl
	>=dev-lisp/gauche-0.6
	>=media-libs/glut-3.7"
RDEPEND="$DEPEND"
S=${WORKDIR}/Gauche-gl

src_unpack() {
	unpack Gauche-gl-${PV}.tgz || die
	cd ${S}
	patch -p1 < ${FILESDIR}/${PV}/nvidia-headers-gentoo.diff || die
	patch -p1 < ${FILESDIR}/${PV}/destdir-gentoo.diff || die
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	#emake || die
	make || die
}

src_install () {
	dodir `gauche-config --syslibdir`
	dodir `gauche-config --sysarchdir`
	dodir `gauche-config --sysincdir`

	make DESTDIR=${D} install || die

	dodoc COPYING README ChangeLog INSTALL* VERSION 
	local expls=/usr/share/${P}/examples
	dodir ${expls}/glbook
	insinto ${expls}
	doins examples/mandelbrot.scm
	insinto ${expls}/glbook
	doins examples/glbook/*
}
