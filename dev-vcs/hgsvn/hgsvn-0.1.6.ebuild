# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/hgsvn/hgsvn-0.1.6.ebuild,v 1.2 2010/06/22 18:48:52 arfrever Exp $

NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="A set of scripts to work locally on Subversion checkouts using Mercurial"
HOMEPAGE="http://cheeseshop.python.org/pypi/hgsvn"
SRC_URI="http://cheeseshop.python.org/packages/source/h/hgsvn/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}
	dev-vcs/subversion
	|| ( >=dev-lang/python-2.5 dev-python/elementtree )"
