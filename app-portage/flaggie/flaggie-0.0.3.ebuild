# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/flaggie/flaggie-0.0.3.ebuild,v 1.2 2010/12/19 21:54:47 mgorny Exp $

EAPI=2
PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="2.4 2.5"

inherit base distutils

DESCRIPTION="A smart CLI mangler for package.* files"
HOMEPAGE="https://github.com/mgorny/flaggie/"
SRC_URI="https://github.com/downloads/mgorny/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=sys-apps/portage-2.1.8.3"

src_prepare() {
	base_src_prepare
	distutils_src_prepare
}

pkg_postinst() {
	distutils_pkg_postinst

	ewarn "Please notice that flaggie is a fairly young project, and can definitely"
	ewarn "be buggy. It is suggested that you backup your package.* files before"
	ewarn "using it for the first time to prevent potential data loss."
}
