# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/bitbake/bitbake-1.8.18-r1.ebuild,v 1.3 2011/04/06 18:44:08 arfrever Exp $

EAPI="3"
inherit distutils

if [[ ${PV} == "9999" ]] ; then
	ESVN_REPO_URI="svn://svn.berlios.de/bitbake/trunk/bitbake"
	inherit subversion
	SRC_URI=""
	KEYWORDS="amd64 ppc x86"
else
	SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"
	KEYWORDS="amd64 ppc x86"
fi

DESCRIPTION="package management tool for OpenEmbedded"
HOMEPAGE="http://developer.berlios.de/projects/bitbake/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	|| (
		>=dev-lang/python-2.5[sqlite]
		>=dev-python/pysqlite-2.3.2
	)"
