# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/flaggie/flaggie-0.1.1.ebuild,v 1.1 2011/01/19 21:42:05 mgorny Exp $

EAPI=3
PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="2.4 2.5"

inherit base bash-completion distutils

DESCRIPTION="A smart CLI mangler for package.* files"
HOMEPAGE="https://github.com/mgorny/flaggie/"
SRC_URI="http://cloud.github.com/downloads/mgorny/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND=">=sys-apps/portage-2.1.8.3
	bash-completion? ( app-shells/gentoo-bashcomp )"

src_prepare() {
	base_src_prepare
	distutils_src_prepare
}

src_install() {
	distutils_src_install

	dobashcompletion contrib/bash-completion/${PN}.bash-completion || die
}

pkg_postinst() {
	distutils_pkg_postinst

	ewarn "Please denote that flaggie creates backups of your package.*"
	ewarn "and make.conf files through appending a single '~'. If you'd"
	ewarn "like to keep your own backup, please use another naming scheme."

	bash-completion_pkg_postinst
}
