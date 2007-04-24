# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/mayavi/mayavi-1.5.ebuild,v 1.1 2007/04/24 15:55:31 bicatali Exp $

NEED_PYTHON=2.3

inherit distutils

MY_P=MayaVi-${PV}
DESCRIPTION="VTK based scientific data visualizer"
HOMEPAGE="http://mayavi.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="2"
KEYWORDS="~amd64 ~x86"

IUSE="doc examples"
DEPEND=">=sci-libs/vtk-5"
RESTRICT="test"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	python_tkinter_exists

	if ! built_with_use sci-libs/vtk tk python; then
		eerror "vtk is missing tk or python support."
		eerror "Please ensure you have the 'tk' and 'python' USE flags"
		eerror  "enabled for vtk and then re-emerge vtk."
		die "vtk needs tk and python USE flags"
	fi
}

src_install() {
	distutils_src_install
	dodoc doc/{README,CREDITS,NEWS,TODO}.txt
	use doc && dohtml -r doc/guide/*
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/*
	fi
}

pkg_postinst() {
	if ! built_with_use sci-libs/vtk patented ; then
		ewarn "Mayavi may require vtk to be built with the 'patent' USE flag"
		ewarn "to be fully functional"
		fi
}
