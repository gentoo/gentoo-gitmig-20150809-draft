# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/portpeek/portpeek-1.9.83.ebuild,v 1.1 2011/12/19 15:45:32 mpagano Exp $

EAPI="2"
PYTHON_DEPEND="2"

inherit eutils python

DESCRIPTION="A helper program for maintaining the package.keyword and package.unmask files"
HOMEPAGE="http://www.mpagano.com/blog/?page_id=3"
SRC_URI="http://www.mpagano.com/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=">=app-portage/gentoolkit-0.3.0.4
	>=sys-apps/portage-2.1.10.11
	|| ( dev-lang/python:2.6 dev-lang/python:2.7 )"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	python_convert_shebangs 2 portpeek
}

src_install() {
	dobin ${PN} || die "dobin failed"
	doman *.[0-9]
}
