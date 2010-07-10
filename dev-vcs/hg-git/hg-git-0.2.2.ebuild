# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/hg-git/hg-git-0.2.2.ebuild,v 1.4 2010/07/10 15:27:46 fauli Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="push and pull from a Git server using Mercurial"
HOMEPAGE="http://hg-git.github.com/ http://pypi.python.org/pypi/hg-git"
SRC_URI="http://pypi.python.org/packages/source/h/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~ppc-macos ~x86-solaris"
IUSE=""

RDEPEND=">=dev-vcs/mercurial-1.1
		<dev-vcs/mercurial-1.6
		>=dev-python/dulwich-0.6"
DEPEND="${RDEPEND}
	dev-python/setuptools"

PYTHON_MODNAME="hggit"
