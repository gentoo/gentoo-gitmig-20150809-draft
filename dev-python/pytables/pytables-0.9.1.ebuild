# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pytables/pytables-0.9.1.ebuild,v 1.1 2004/12/07 02:59:52 kloeri Exp $

inherit distutils

DESCRIPTION="Module for Python that use HDF5"
SRC_URI="mirror://sourceforge/pytables/${P}.tar.gz"
HOMEPAGE="http://pytables.sourceforge.net/"

DEPEND=">=dev-lang/python-2.2
	>=sys-devel/gcc-3.2
	dev-libs/hdf5
	dev-python/numarray"

SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="as-is"
IUSE=""
