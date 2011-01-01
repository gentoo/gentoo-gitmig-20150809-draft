# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pytools/pytools-9999.ebuild,v 1.3 2011/01/01 21:08:52 arfrever Exp $

EAPI="3"

inherit git distutils

EGIT_REPO_URI="http://git.tiker.net/trees/pytools.git"

DESCRIPTION="A collection of tools missing from the Python standard library"
HOMEPAGE="http://mathema.tician.de/software/pytools"

SRC_URI=""
LICENSE="MIT"
KEYWORDS=""
SLOT="0"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

src_unpack() {
	git_src_unpack
}
