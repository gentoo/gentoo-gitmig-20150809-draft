# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/aquarium/aquarium-2.3.ebuild,v 1.1 2009/02/03 19:19:09 patrick Exp $

inherit distutils

DESCRIPTION="Aquarium web application framework (Python)"
HOMEPAGE="http://aquarium.sourceforge.net/"
SRC_URI="mirror://sourceforge/aquarium/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.2
dev-python/cheetah"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="Aquarium"
DOCS="README TODO"

