# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hgtools/hgtools-2.0.2.ebuild,v 1.2 2012/12/28 04:19:45 prometheanfire Exp $

EAPI=4

inherit distutils

MY_PN=${PN#python-}
S="${WORKDIR}/${MY_PN}-${PV}"
DESCRIPTION="Classes and setuptools plugin for Mercurial repositories"
HOMEPAGE="https://bitbucket.org/jaraco/hgtools/"
SRC_URI="mirror://pypi/h/${MY_PN}/${MY_PN}-${PV}.zip"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""
DEPEND="dev-python/setuptools"
RDEPEND=""

src_install() {
	distutils_src_install
}
