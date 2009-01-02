# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/bitbake/bitbake-9999.ebuild,v 1.5 2009/01/02 21:13:29 vapier Exp $

if [[ ${PV} == "9999" ]] ; then
	ESVN_REPO_URI="svn://svn.berlios.de/bitbake/trunk/bitbake"
	inherit subversion
	SRC_URI=""
else
	SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"
fi

DESCRIPTION="package management tool for OpenEmbedded"
HOMEPAGE="http://developer.berlios.de/projects/bitbake/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-lang/python
	dev-python/pysqlite"

src_install() {
	python setup.py install --root="${D}" || die "setup failed"
}
