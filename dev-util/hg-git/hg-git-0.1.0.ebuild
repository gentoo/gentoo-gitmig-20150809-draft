# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/hg-git/hg-git-0.1.0.ebuild,v 1.3 2009/12/07 12:51:36 djc Exp $

SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="push and pull from a Git server using Mercurial"
HOMEPAGE="http://hg-git.github.com/ http://pypi.python.org/pypi/hg-git"
SRC_URI="http://pypi.python.org/packages/source/h/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

DEPEND=""
RDEPEND=">=dev-util/mercurial-1.1
	>=dev-python/dulwich-0.4"

RESTRICT_PYTHON_ABIS="3.*"
