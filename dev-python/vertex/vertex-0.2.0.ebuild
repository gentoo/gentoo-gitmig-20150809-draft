# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/vertex/vertex-0.2.0.ebuild,v 1.3 2009/09/06 20:28:44 idl0r Exp $

inherit distutils eutils

DESCRIPTION="An implementation of the Q2Q protocol"
HOMEPAGE="http://divmod.org/trac/wiki/DivmodVertex"
SRC_URI="mirror://gentoo/Vertex-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~ia64 ~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/python-2.4
	>=dev-python/twisted-2.4
	>=dev-python/pyopenssl-0.6
	>=dev-libs/openssl-0.9.7
	>=dev-python/epsilon-0.5.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/Vertex-${PV}"

DOCS="NAME.txt"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-structlike.patch"
}

src_test() {
	PYTHONPATH="." trial vertex || die "trial failed"
}
