# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/portpeek/portpeek-1.5.8.4.ebuild,v 1.11 2010/11/26 21:07:27 mpagano Exp $

EAPI="2"
PYTHON_DEPEND="2"

inherit eutils python

DESCRIPTION="A helper program for maintaining the package.keyword and package.unmask files"
HOMEPAGE="http://www.mpagano.com/blog/?page_id=3"
SRC_URI="http://www.mpagano.com/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm ppc sparc x86"
IUSE=""

DEPEND=""
RDEPEND="<app-portage/gentoolkit-0.3.0
	<sys-apps/portage-2.1.9
	dev-lang/python:2.6"

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
