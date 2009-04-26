# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/weberror/weberror-0.10.1.ebuild,v 1.1 2009/04/26 09:48:13 patrick Exp $

inherit distutils

MY_PN="WebError"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Web Error handling and exception catching"
HOMEPAGE="http://pythonpaste.org/webob/"
SRC_URI="http://pypi.python.org/packages/source/W/${MY_PN}/${MY_P}.tar.gz"
LICENSE="MIT"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""
S="${WORKDIR}/${MY_P}"
DEPEND="dev-python/setuptools"
RDEPEND=""
