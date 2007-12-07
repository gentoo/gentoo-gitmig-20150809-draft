# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyspf/pyspf-2.0.3.ebuild,v 1.3 2007/12/07 07:27:17 opfer Exp $

inherit distutils

DESCRIPTION="Python implementation of the Sender Policy Framework (SPF) protocol"
SRC_URI="mirror://sourceforge/pymilter/${P}.tar.gz"
HOMEPAGE="http://cheeseshop.python.org/pypi/pyspf"

IUSE=""
SLOT="0"
LICENSE="PSF-2.4"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/pydns"
RDEPEND="dev-python/pydns"
