# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-gudev/python-gudev-147.2.ebuild,v 1.7 2011/10/24 05:38:59 tetromino Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.* *-jython"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"

inherit autotools python

DESCRIPTION="Python binding to the GUDev udev helper library"
HOMEPAGE="http://github.com/nzjrs/python-gudev"
SRC_URI="https://github.com/nzjrs/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/pygobject:2
|| ( >=sys-fs/udev-171[gudev] >=sys-fs/udev-147[extras] )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/nzjrs-${PN}-ee8a644

src_prepare() {
	eautoreconf
	python_src_prepare
}

src_configure() {
	python_src_configure --disable-static
}

src_install() {
	python_src_install
	python_clean_installation_image
	dodoc AUTHORS NEWS README || die "dodoc failed"
}
