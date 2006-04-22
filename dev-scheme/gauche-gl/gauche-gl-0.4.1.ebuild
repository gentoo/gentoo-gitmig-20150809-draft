# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/gauche-gl/gauche-gl-0.4.1.ebuild,v 1.2 2006/04/22 15:19:15 hattya Exp $

inherit eutils flag-o-matic

IUSE="cg"

MY_P="${P/g/G}"

DESCRIPTION="OpenGL binding for Gauche"
HOMEPAGE="http://gauche.sf.net/"
SRC_URI="mirror://sourceforge/gauche/${MY_P}.tgz"

LICENSE="BSD"
KEYWORDS="~ppc x86"
SLOT="0"
S="${WORKDIR}/${MY_P}"

DEPEND="virtual/opengl
	>=media-libs/glut-3.7
	>=dev-lang/gauche-0.8.6
	cg? ( media-gfx/nvidia-cg-toolkit )"

src_compile() {

	local myconf

	filter-flags -fforce-addr

	if use cg; then
		myconf="--enable-cg"
	fi

	econf ${myconf} || die
	emake || die

}

src_install() {

	dodir $(gauche-config --syslibdir)
	dodir $(gauche-config --sysincdir)
	dodir $(gauche-config --sysarchdir)

	make DESTDIR=${D} install || die

	insinto $(gauche-config --syslibdir)/gl
	doins lib/gl/simple-image.scm

	dodoc README ChangeLog INSTALL* COPYING

	docinto examples
	dodoc examples/*.scm

	# install glbook
	docinto examples/glbook
	dodoc examples/glbook/*

	docinto examples/images
	dodoc examples/images/*

	# install slbook
	docinto examples/slbook
	dodoc examples/slbook/*

	docinto examples/slbook/ogl2brick
	dodoc examples/slbook/ogl2brick/*

	docinto examples/slbook/ogl2particle
	dodoc examples/slbook/ogl2particle/*

	# install cg examples
	if use cg; then
		docinto examples/cg
		dodoc examples/cg/*
	fi

}
