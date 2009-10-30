# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fpconst/fpconst-0.7.3.ebuild,v 1.11 2009/10/30 18:05:14 maekke Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python Module for handling IEEE 754 floating point special values"
HOMEPAGE="http://chaco.bst.rochester.edu:8080/statcomp/projects/RStatServer/fpconst/ http://pypi.python.org/pypi/fpconst http://sourceforge.net/projects/rsoap/files/"
SRC_URI="mirror://sourceforge/rsoap/${P}.tar.gz"

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="fpconst.py"
DOCS="pep-0754.txt"
