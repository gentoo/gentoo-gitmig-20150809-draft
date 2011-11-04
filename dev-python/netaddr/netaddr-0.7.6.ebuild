# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/netaddr/netaddr-0.7.6.ebuild,v 1.1 2011/11/04 21:23:26 maksbotan Exp $

EAPI=4

SUPPORT_PYTHON_ABIS=1
PYTHON_DEPEND="2:2.6"
DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES=1

inherit python distutils

DESCRIPTION="Network address representation and manipulation library."
HOMEPAGE="http://github.com/drkjam/netaddr"
SRC_URI="https://github.com/downloads/drkjam/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
