# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/beanstalkc/beanstalkc-0.1.1.ebuild,v 1.1 2009/06/23 12:15:17 patrick Exp $

NEED_PYTHON=2.5

inherit distutils

DESCRIPTION="A simple beanstalkd client library"
HOMEPAGE="http://github.com/earl/beanstalkc"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="dev-lang/python"

DOCS="README"
