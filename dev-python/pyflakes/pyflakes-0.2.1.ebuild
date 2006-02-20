# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyflakes/pyflakes-0.2.1.ebuild,v 1.1 2006/02/20 15:09:15 marienz Exp $

inherit distutils

DESCRIPTION="passive checker for python programs"
HOMEPAGE="http://divmod.org/projects/pyflakes"
SRC_URI="http://divmod.org/static/projects/pyflakes/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=virtual/python-2.3"
