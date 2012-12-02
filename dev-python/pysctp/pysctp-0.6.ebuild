# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysctp/pysctp-0.6.ebuild,v 1.3 2012/12/02 02:56:41 zx2c4 Exp $

EAPI=4

inherit distutils

DESCRIPTION="PySCTP gives access to the SCTP transport protocol from Python."
HOMEPAGE="https://github.com/philpraxis/pysctp"
SRC_URI="https://github.com/philpraxis/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

PYTHON_DEPEND="2"
DEPEND="net-misc/lksctp-tools"
RDEPEND="${DEPEND}"

src_install() {
	distutils_src_install
	rm -v "${D}/usr/_sctp.h"
	dodoc test_local_cnx.py test_remote_cnx.py
}
