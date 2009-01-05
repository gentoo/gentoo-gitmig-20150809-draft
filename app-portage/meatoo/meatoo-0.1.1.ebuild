# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/meatoo/meatoo-0.1.1.ebuild,v 1.4 2009/01/05 19:23:55 patrick Exp $

inherit distutils

PYTHON_MODNAME="meatoo_client"
DESCRIPTION="Command-line client for Meatoo using XML-RPC."
HOMEPAGE="http://tools.assembla.com/meatoo/"
SRC_URI="http://cheeseshop.python.org/packages/source/m/meatoo/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""
DEPEND=">=dev-python/setuptools-0.6_rc3"
