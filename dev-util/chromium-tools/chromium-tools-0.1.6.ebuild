# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/chromium-tools/chromium-tools-0.1.6.ebuild,v 1.4 2011/02/05 22:51:23 maekke Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"

inherit distutils python

DESCRIPTION="Collection of Chromium-related scripts for Gentoo"
HOMEPAGE="http://www.gentoo.org/proj/en/desktop/chromium/index.xml"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~arm x86 ~amd64-linux ~x86-linux"
IUSE="subversion"

DEPEND=""
RDEPEND="
	${DEPEND}
	subversion? ( dev-python/pysvn )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup

	DISTUTILS_GLOBAL_OPTIONS=("$(use_enable subversion)")
}
