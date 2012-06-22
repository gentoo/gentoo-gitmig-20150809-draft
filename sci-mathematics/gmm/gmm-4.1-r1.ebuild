# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/gmm/gmm-4.1-r1.ebuild,v 1.1 2012/06/22 10:03:08 kensington Exp $

EAPI=4

inherit base

DESCRIPTION="Generic C++ template library for sparse, dense and skyline matrices"
SRC_URI="http://download.gna.org/getfem/stable/${P}.tar.gz"
HOMEPAGE="http://www-gmm.insa-toulouse.fr/getfem/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

DOCS=( AUTHORS )
PATCHES=( "${FILESDIR}/${P}-gcc-4.7.patch" )
