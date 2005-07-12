# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fxpy/fxpy-1.0.5-r1.ebuild,v 1.2 2005/07/12 11:03:10 dholm Exp $

inherit distutils eutils

MY_P="FXPy-${PV}"

DESCRIPTION="Fox Toolkit GUI bindings for Python."
HOMEPAGE="http://fxpy.sourceforge.net/"
SRC_URI="mirror://sourceforge/fxpy/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="doc opengl"

DEPEND="virtual/python
	=x11-libs/fox-1.0*
	opengl? ( >=dev-python/pyopengl-2.0.0.44 )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A} || die
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff || die "Patch failed."
}

src_install() {
	distutils_src_install

	if use doc ; then
		dohtml doc/*
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
		insinto /usr/share/doc/${PF}/examples/icons
		doins examples/icons/*
		insinto /usr/share/doc/${PF}/contrib
		doins contrib/*
	fi
}
