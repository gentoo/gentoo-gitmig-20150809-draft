# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/gauche-gl/gauche-gl-0.5.ebuild,v 1.1 2011/06/14 14:42:41 hattya Exp $

EAPI="3"

inherit eutils

IUSE="cg examples"

MY_P="${P/g/G}"

DESCRIPTION="OpenGL binding for Gauche"
HOMEPAGE="http://practical-scheme.net/gauche"
SRC_URI="mirror://sourceforge/gauche/${MY_P}.tgz"

LICENSE="BSD"
KEYWORDS="~ppc ~x86"
SLOT="0"
S="${WORKDIR}/${MY_P}"

DEPEND=">=dev-scheme/gauche-0.9.1
	virtual/opengl
	media-libs/freeglut
	cg? ( media-gfx/nvidia-cg-toolkit )"
RDEPEND="${DEPEND}"

src_configure() {
	local myconf
	use cg && myconf="--enable-cg"

	econf ${myconf} || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README ChangeLog || die

	if use examples; then
		docinto examples
		dodoc examples/*.scm

		# install simple
		docinto examples/simple
		dodoc examples/simple/*

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
	fi
}
