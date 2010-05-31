# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/mayavi/mayavi-1.5-r1.ebuild,v 1.5 2010/05/31 07:23:16 jlec Exp $

EAPI="2"

PYTHON_DEPEND="2"
PYTHON_USE_WITH="tk"

inherit distutils eutils

PYTHON_MODNAME=enthought

MY_P=MayaVi-${PV}
DESCRIPTION="VTK based scientific data visualizer"
HOMEPAGE="http://mayavi.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="1"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND="
	=sci-libs/vtk-5.4*[tk,python]"
RDEPEND="${DEPEND}"

RESTRICT="test"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}"/mayavi-1.5-tkinter_objects.patch
	distutils_src_prepare
}

src_install() {
	distutils_src_install
	dodoc doc/{README,CREDITS,NEWS,TODO}.txt
	use doc && dohtml -r doc/guide/*
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die
	fi
	make_desktop_entry mayavi "Mayavi1 2D/3D Scientific Visualization"
}

pkg_postinst() {
	if ! has_version sci-libs/vtk[patented]; then
		elog "Mayavi may require vtk to be built with the 'patent' USE flag"
		elog "to be fully functional"
	fi
}
