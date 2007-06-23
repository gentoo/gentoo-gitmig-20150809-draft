# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/yolk-portage/yolk-portage-0.1.ebuild,v 1.3 2007/06/23 09:04:25 lucass Exp $

NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="Gentoo Portage plugin for yolk"
HOMEPAGE="http://cheeseshop.python.org/pypi/yolk"
SRC_URI="http://cheeseshop.python.org/packages/source/y/yolk-portage/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=">=app-portage/portage-utils-0.1.23"
