# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/webtest/webtest-1.0.ebuild,v 1.1 2008/07/02 05:19:59 pythonhead Exp $

inherit distutils

MY_PN="WebTest"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Helper to test WSGI applications"
HOMEPAGE="http://pythonpaste.org/webtest/"
SRC_URI="http://pypi.python.org/packages/source/W/${MY_PN}/${MY_P}.tar.gz"
LICENSE="MIT"
KEYWORDS="~x86"
SLOT="0"
IUSE=""
S="${WORKDIR}/${MY_P}"
DEPEND="dev-python/setuptools"
RDEPEND="|| ( >=dev-python/wsgiref-0.1.2 >=dev-lang/python-2.5.2-r4 )
	>=dev-python/webob-0.9.2"


