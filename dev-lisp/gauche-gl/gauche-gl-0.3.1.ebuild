# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/gauche-gl/gauche-gl-0.3.1.ebuild,v 1.1 2003/12/31 04:38:57 george Exp $

inherit base

DESCRIPTION="OpenGL 1.1 bindings for Gauche"
HOMEPAGE="http://gauche.sf.net"
SRC_URI="mirror://sourceforge/gauche/Gauche-gl-${PV}.tgz"

LICENSE="BSD"
SLOT="0.1"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	virtual/opengl
	>=dev-lisp/gauche-0.7.3
	>=media-libs/glut-3.7"

My_PN=${PN/g/G}
S=${WORKDIR}/${My_PN}-${PV}
PATCHES1="${FILESDIR}/nvidia-headers-gentoo.diff
	${FILESDIR}/destdir-gentoo.diff"

src_install () {
	dodir `gauche-config --syslibdir`
	dodir `gauche-config --sysarchdir`
	dodir `gauche-config --sysincdir`

	make DESTDIR=${D} install || die

	dodoc COPYING README ChangeLog INSTALL* VERSION
	local expls=/usr/share/${PN}/examples
	dodir ${expls}/glbook
	insinto ${expls}
	doins examples/mandelbrot.scm
	insinto ${expls}/glbook
	doins examples/glbook/*
}
