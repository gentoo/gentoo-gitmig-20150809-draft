# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/pyGPG/pyGPG-9999.ebuild,v 1.1 2012/11/19 00:01:48 dolsen Exp $

EAPI="4"

PYTHON_COMPAT=(python{2_5,2_6,2_7})

EGIT_MASTER="pyGPG"
EGIT_BRANCH="master"

inherit distutils-r1 python-r1 git-2

EGIT_REPO_URI="git://github.com/dol-sen/pyGPG.git"

DESCRIPTION="A python interface wrapper for gnupg's gpg command"
HOMEPAGE="https://github.com/dol-sen/pyGPG"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
IUSE=""

KEYWORDS=""

DEPEND =""
RDEPEND="${DEPEND}
	>=app-crypt/gnupg-2.0.0
	"

python_install_all() {
	distutils-r1_python_install_all
}

pkg_postinst() {
	einfo
	einfo "This is experimental software."
	einfo "The API's it installs should be considered unstable"
	einfo "and are subject to change."
	einfo
	einfo "Please file any enhancement requests, or bugs"
	einfo "at https://github.com/dol-sen/pyGPG/issues"
	einfo "I am also on IRC @ #porthole of the freenode network"
	einfo
}
