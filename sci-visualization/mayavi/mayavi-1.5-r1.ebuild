# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/mayavi/mayavi-1.5-r1.ebuild,v 1.1 2009/01/16 09:44:14 bicatali Exp $

NEED_PYTHON=2.3
EAPI=2
inherit eutils distutils

MY_P=MayaVi-${PV}
DESCRIPTION="VTK based scientific data visualizer"
HOMEPAGE="http://mayavi.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="1"
KEYWORDS="~amd64 ~x86"

IUSE="doc examples"
DEPEND="dev-lang/python[tk]
	>=sci-libs/vtk-5[tk,python]"
RESTRICT="test"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/mayavi-1.5-tkinter_objects.patch
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
	if ! built_with_use sci-libs/vtk patented ; then
		elog "Mayavi may require vtk to be built with the 'patent' USE flag"
		elog "to be fully functional"
	fi
}
