# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/stomper/stomper-0.2.2.ebuild,v 1.2 2009/04/19 16:38:09 mr_bones_ Exp $

inherit distutils

DESCRIPTION="This is a transport neutral client implementation of the STOMP protocol."
HOMEPAGE="http://pypi.python.org/pypi/stomper/${PV}"
SRC_URI="http://pypi.python.org/packages/source/s/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-lang/python"
DEPEND="${RDEPEND}
	dev-python/setuptools"

src_install() {
	distutils_src_install
}
