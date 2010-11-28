# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/chromium-tools/chromium-tools-0.1.2.ebuild,v 1.1 2010/11/28 18:46:04 phajdan.jr Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"

inherit distutils python

DESCRIPTION="Collection of Chromium-related scripts for Gentoo"
HOMEPAGE="http://www.gentoo.org/proj/en/desktop/chromium/index.xml"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="
	${DEPEND}
	dev-python/pysvn"

pkg_setup() {
	python_set_active_version 2
}
