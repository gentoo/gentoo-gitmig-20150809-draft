# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask-themes/flask-themes-0.1.2.ebuild,v 1.1 2010/12/14 23:21:53 rafaelmartins Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="Flask-Themes"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Infrastructure for theming support in Flask applications."
HOMEPAGE="http://packages.python.org/Flask-Themes/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-python/flask-0.6
	|| ( >=dev-lang/python-2.6 dev-python/simplejson )"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( dev-python/nose )"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="flaskext/themes.py"
