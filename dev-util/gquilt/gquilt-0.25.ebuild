# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gquilt/gquilt-0.25.ebuild,v 1.1 2011/04/25 20:11:55 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils

DESCRIPTION="A Python/GTK wrapper for quilt"
HOMEPAGE="http://gquilt.sourceforge.net/ http://sourceforge.net/projects/gquilt/"
SRC_URI="mirror://sourceforge/gquilt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-python/pygtk:2
	dev-util/quilt"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="gquilt_pkg"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	distutils_src_prepare
	python_convert_shebangs -r 2 .
}

src_install() {
	distutils_src_install

	dobin ${PN} || die "dobin failed"

	insinto /usr/share/applications
	doins gquilt.desktop || die "doins failed"
}
