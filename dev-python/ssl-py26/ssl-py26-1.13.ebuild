# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ssl-py26/ssl-py26-1.13.ebuild,v 1.1 2008/05/05 17:19:35 chtekk Exp $

NEED_PYTHON=2.3

inherit distutils

MY_PN="ssl"
MY_P="${MY_PN}-${PV}"

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Backport of the Python 2.6 ssl module."
HOMEPAGE="http://docs.python.org/dev/library/${MY_PN}.html"
SRC_URI="http://cheeseshop.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="PYTHON"
SLOT="0"
IUSE=""

RDEPEND=">=dev-libs/openssl-0.9.8
		!>=dev-lang/python-2.6"

DEPEND="${RDEPEND}
		dev-python/setuptools"

S="${WORKDIR}/${MY_P}"
