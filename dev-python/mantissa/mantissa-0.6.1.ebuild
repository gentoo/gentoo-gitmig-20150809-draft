# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mantissa/mantissa-0.6.1.ebuild,v 1.1 2007/11/02 19:18:01 hawking Exp $

inherit distutils eutils

DESCRIPTION="An extensible, multi-protocol, multi-user, interactive application server"
HOMEPAGE="http://divmod.org/trac/wiki/DivmodMantissa"
SRC_URI="mirror://gentoo/Mantissa-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~ia64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4
	>=dev-python/twisted-2.4
	dev-python/twisted-mail
	>=dev-python/nevow-0.9.5
	>=dev-python/axiom-0.5.7
	>=dev-python/vertex-0.2
	>=dev-python/pytz-2005m"

S="${WORKDIR}/Mantissa-${PV}"

DOCS="NAME.txt NEWS.txt"

src_compile() {
	# skip this, or epsilon will install the temporary "build" dir
	true
}

src_test() {
	PYTHONPATH=. trial xmantissa || die "trial failed"
}
