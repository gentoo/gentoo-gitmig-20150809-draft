# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/git-python/git-python-0.1.6.ebuild,v 1.4 2010/03/17 16:49:57 sping Exp $

inherit distutils

DESCRIPTION="git-python is a python library used to interact with Git
repositories."
HOMEPAGE="http://gitorious.org/git-python"
SRC_URI="http://pypi.python.org/packages/source/G/GitPython/GitPython-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="virtual/python
	dev-vcs/git"

S=${WORKDIR}/GitPython-${PV}
