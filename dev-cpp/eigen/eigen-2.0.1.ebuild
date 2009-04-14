# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/eigen/eigen-2.0.1.ebuild,v 1.1 2009/04/14 17:55:42 scarabeus Exp $

EAPI="2"
inherit cmake-utils

DESCRIPTION="Lightweight C++ template library for vector and matrix math, a.k.a. linear algebra"
HOMEPAGE="http://eigen.tuxfamily.org/"
SRC_URI="http://download.tuxfamily.org/${PN}/${P/_/-}.tar.bz2"

LICENSE="GPL-3"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="!dev-cpp/eigen:0"
RDEPEND="${DEPEND}"
