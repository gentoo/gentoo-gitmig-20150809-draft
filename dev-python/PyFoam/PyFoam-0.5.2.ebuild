# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyFoam/PyFoam-0.5.2.ebuild,v 1.1 2009/04/26 10:14:49 patrick Exp $

EAPI="2"

inherit eutils distutils

DESCRIPTION="Tool to analyze and plot the residual files of OpenFOAM computations"
HOMEPAGE="http://openfoamwiki.net/index.php/Contrib_PyFoam"
SRC_URI="http://openfoamwiki.net/images/2/28/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${DEPEND}
	sci-visualization/gnuplot
	|| ( sci-libs/openfoam-meta sci-libs/openfoam sci-libs/openfoam-bin ) "
