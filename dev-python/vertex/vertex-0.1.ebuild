# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/vertex/vertex-0.1.ebuild,v 1.1 2005/12/05 17:06:16 marienz Exp $

inherit distutils eutils

DESCRIPTION="An implementation of the Q2Q protocol"
HOMEPAGE="http://divmod.org/trac/wiki/DivmodVertex"
SRC_URI="http://divmod.org/static/projects/vertex/Vertex-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4
	>=dev-python/twisted-2.1
	>=dev-python/pyopenssl-0.6
	>=dev-libs/openssl-0.9.7
	>=dev-python/epsilon-0.1"

S="${WORKDIR}/Vertex-${PV}"

DOCS="NAME.txt"

src_test() {
	trial -R vertex || die "trial failed"
}
