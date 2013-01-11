# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ranger/ranger-9999.ebuild,v 1.3 2013/01/11 22:25:09 radhermit Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} )
PYTHON_REQ_USE="ncurses"

inherit distutils-r1 git-2

EGIT_REPO_URI="git://git.savannah.nongnu.org/ranger.git"

DESCRIPTION="A vim-inspired file manager for the console"
HOMEPAGE="http://ranger.nongnu.org/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="virtual/pager"

pkg_postinst() {
	elog "Ranger has many optional dependencies to support enhanced file previews."
	elog "See the README or homepage for more details."
}
