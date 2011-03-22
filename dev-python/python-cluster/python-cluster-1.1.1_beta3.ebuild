# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-cluster/python-cluster-1.1.1_beta3.ebuild,v 1.2 2011/03/22 19:05:45 angelos Exp $

EAPI=3

PYTHON_DEPEND="*"
SUPPORT_PYTHON_ABIS=1
PYTHON_MODNAME="cluster.py"

inherit distutils eutils

MY_P=cluster-${PV/_beta/b}
DESCRIPTION="Allows grouping a list of arbitrary objects into related groups (clusters)"
HOMEPAGE="http://python-cluster.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/python-cluster-python3.patch
	distutils_src_prepare
}
