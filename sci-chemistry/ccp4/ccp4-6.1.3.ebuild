# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/ccp4/ccp4-6.1.3.ebuild,v 1.3 2011/06/21 16:05:14 jlec Exp $

EAPI="2"

DESCRIPTION="Protein X-ray crystallography toolkit -- meta package"
HOMEPAGE="http://www.ccp4.ac.uk/"
SRC_URI=""

LICENSE="ccp4"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X arpwarp +balbes"

RDEPEND="
	virtual/fortran

	~sci-chemistry/ccp4-apps-${PV}[X?]
	sci-chemistry/molrep
	sci-chemistry/mosflm
	sci-chemistry/mrbump[X?]
	sci-chemistry/oasis
	sci-chemistry/pdb-extract
	sci-chemistry/refmac
	sci-chemistry/scala
	sci-chemistry/sfcheck
	sci-chemistry/xia2
	arpwarp? ( sci-chemistry/arp-warp-bin )
	balbes? ( sci-chemistry/balbes )
	X? (
		~sci-chemistry/ccp4i-${PV}
		sci-chemistry/imosflm
		sci-chemistry/pymol
		sci-chemistry/rasmol
		)"
DEPEND=""
