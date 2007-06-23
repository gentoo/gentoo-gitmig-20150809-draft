# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/hgsvn/hgsvn-0.1.3.ebuild,v 1.2 2007/06/23 22:30:50 cedk Exp $

inherit distutils

DESCRIPTION="A set of scripts to work locally on Subversion checkouts using Mercurial"
HOMEPAGE="http://cheeseshop.python.org/pypi/hgsvn/0.1.3"
SRC_URI="http://cheeseshop.python.org/packages/source/h/hgsvn/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="dev-util/subversion
	|| ( >=dev-lang/python-2.5 dev-python/elementtree )"
