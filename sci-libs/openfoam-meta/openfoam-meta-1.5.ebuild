# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/openfoam-meta/openfoam-meta-1.5.ebuild,v 1.1 2009/04/25 16:28:29 patrick Exp $

DESCRIPTION="Open Field Operation and Manipulation - CFD Simulation Toolbox"
HOMEPAGE="http://www.opencfd.co.uk/openfoam/"

LICENSE="GPL-2"
SLOT="1.5"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="!=sci-libs/openfoam-${PV}*
	!=sci-libs/openfoam-bin-${PV}*
	=sci-libs/openfoam-kernel-${PV}*
	=sci-libs/openfoam-solvers-${PV}*
	=sci-libs/openfoam-utilities-${PV}*
	=sci-libs/openfoam-wmake-${PV}*"
DEPEND="${RDEPEND}"
