# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pymountboot/pymountboot-0.1.ebuild,v 1.1 2012/05/11 17:19:59 mgorny Exp $

EAPI=4
PYTHON_COMPAT='python2_6 python2_7'

inherit base python-distutils-ng

DESCRIPTION="Python extension module to (re)mount /boot"
HOMEPAGE="https://bitbucket.org/mgorny/pymountboot/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=sys-apps/util-linux-2.20"
DEPEND="${RDEPEND}"

python_prepare_all() {
	base_src_prepare
}
