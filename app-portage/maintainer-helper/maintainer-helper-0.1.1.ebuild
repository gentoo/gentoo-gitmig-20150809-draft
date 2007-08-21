# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/maintainer-helper/maintainer-helper-0.1.1.ebuild,v 1.3 2007/08/21 15:44:23 rbu Exp $

inherit qt4 distutils

DESCRIPTION="An application to help with ebuild maintenance"
HOMEPAGE="http://dev.gentoo.org/~jokey/maintainer-helper"
SRC_URI="http://dev.gentoo.org/~jokey/maintainer-helper/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/python-2.4
	$(qt4_min_version 4.3)
	>=dev-python/PyQt4-4.2
	>=sys-apps/pkgcore-0.3.1
	>=dev-python/snakeoil-0.1_rc2
	app-editors/gvim"
