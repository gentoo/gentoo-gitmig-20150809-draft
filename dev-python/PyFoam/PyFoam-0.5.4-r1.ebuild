# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyFoam/PyFoam-0.5.4-r1.ebuild,v 1.1 2010/10/17 21:48:06 patrick Exp $

EAPI="2"

inherit eutils distutils

DESCRIPTION="Tool to analyze and plot the residual files of OpenFOAM computations"
HOMEPAGE="http://openfoamwiki.net/index.php/Contrib_PyFoam"
SRC_URI="http://openfoamwiki.net/images/a/ae/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="extras"

RDEPEND="${DEPEND}
	sci-visualization/gnuplot
	|| ( sci-libs/openfoam sci-libs/openfoam-bin sci-libs/openfoam-meta )
	extras? ( sci-libs/vtk
		dev-python/numpy
		dev-python/ply
		dev-python/matplotlib
		dev-python/PyQt4 )"
