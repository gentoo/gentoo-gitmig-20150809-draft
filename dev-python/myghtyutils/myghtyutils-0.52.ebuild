# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/myghtyutils/myghtyutils-0.52.ebuild,v 1.2 2007/07/04 20:12:14 lucass Exp $

NEED_PYTHON=2.4

inherit distutils

KEYWORDS="~amd64 ~x86"

MY_PN=MyghtyUtils
MY_P=${MY_PN}-${PV}

DESCRIPTION="Set of utility classes used by Myghty templating."
HOMEPAGE="http://www.myghty.org"
SRC_URI="http://cheeseshop.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"
LICENSE="MIT"
SLOT="0"
IUSE="test"

RDEPEND="dev-python/myghty"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"
