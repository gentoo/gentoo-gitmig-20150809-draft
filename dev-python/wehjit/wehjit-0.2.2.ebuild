# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wehjit/wehjit-0.2.2.ebuild,v 1.2 2012/02/23 04:31:57 patrick Exp $

EAPI=3

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="A Python web-widget library"
HOMEPAGE="http://jderose.fedorapeople.org/wehjit"
SRC_URI="http://jderose.fedorapeople.org/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="dev-python/genshi
		dev-python/assets
		dev-python/paste
		dev-python/pygments
		"
DEPEND="${RDEPEND}"

DOCS="README TODO NEWS AUTHORS"

python_enable_pyc
