# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/yolk-portage/yolk-portage-0.1.ebuild,v 1.1 2007/04/23 05:52:32 pythonhead Exp $

inherit distutils

NEED_PYTHON=2.4
DESCRIPTION="Gentoo Portage plugin for yolk"
HOMEPAGE="http://cheeseshop.python.org/pypi/yolk"
SRC_URI="http://cheeseshop.python.org/packages/source/y/yolk-portage/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=app-portage/portage-utils-0.1.23"

