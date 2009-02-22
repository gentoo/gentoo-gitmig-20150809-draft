# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/pbs-python/pbs-python-3.0.1.ebuild,v 1.1 2009/02/22 18:27:48 jsbronder Exp $

inherit distutils

MY_P=${PN/-/_}-${PV}
DESCRIPTION="Python bindings to the PBS C API"
HOMEPAGE="https://subtrac.sara.nl/oss/pbs_python/"
SRC_URI="ftp://ftp.sara.nl/pub/outgoing/${MY_P}.tar.gz"
LICENSE="openpbs as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RDEPEND="sys-cluster/torque"
DEPEND="${RDEPEND}"
S=${WORKDIR}/${MY_P}

src_compile() {
	econf || die
	distutils_src_compile
}
