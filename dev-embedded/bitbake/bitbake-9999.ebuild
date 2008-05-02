# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/bitbake/bitbake-9999.ebuild,v 1.4 2008/05/02 18:15:12 calchan Exp $

ESVN_REPO_URI="svn://svn.berlios.de/bitbake/trunk/bitbake"
inherit subversion eutils

DESCRIPTION="package management tool for OpenEmbedded"
HOMEPAGE="http://developer.berlios.de/projects/bitbake/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-lang/python
	dev-python/pysqlite"

src_install() {
	python setup.py install --root="${D}" || die "setup failed"
}
