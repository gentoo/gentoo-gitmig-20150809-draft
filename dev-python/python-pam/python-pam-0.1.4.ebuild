# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-pam/python-pam-0.1.4.ebuild,v 1.1 2012/11/28 21:36:45 prometheanfire Exp $

EAPI=4

inherit distutils

MY_PN=${PN#python-}
S="${WORKDIR}/${MY_PN}-${PV}"
DESCRIPTION="A python interface to the PAM library on linux using ctypes."
HOMEPAGE="http://atlee.ca/software/pam"
SRC_URI="mirror://pypi/p/${MY_PN}/${MY_PN}-${PV}.tar.gz"
LICENSE="BSD-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""
DEPEND="dev-python/setuptools"
RDEPEND=""

src_install() {
	distutils_src_install
}
