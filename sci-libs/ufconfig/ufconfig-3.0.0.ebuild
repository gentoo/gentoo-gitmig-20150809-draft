# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/ufconfig/ufconfig-3.0.0.ebuild,v 1.1 2007/08/18 17:11:47 bicatali Exp $

MY_PN=UFconfig

DESCRIPTION="Common configuration scripts for the SuiteSparse libraries"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/UFconfig"
SRC_URI="http://www.cise.ufl.edu/research/sparse/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""

S="${WORKDIR}/${MY_PN}"

src_install() {
	insinto /usr/include
	doins UFconfig.h
}
