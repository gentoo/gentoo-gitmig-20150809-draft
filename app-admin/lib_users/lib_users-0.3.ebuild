# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/lib_users/lib_users-0.3.ebuild,v 1.6 2012/03/06 20:44:58 ranger Exp $

EAPI=3
PYTHON_DEPEND="2"

inherit python

DESCRIPTION="goes through /proc and finds all cases of libraries being mapped
but marked as deleted"
HOMEPAGE="http://schwarzvogel.de/software-misc.shtml"
SRC_URI="http://schwarzvogel.de/pkgs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ~x86"
IUSE="test"

DEPEND="test? ( dev-python/nose )"
RDEPEND=""

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	python_convert_shebangs -r 2 .
}

src_test() {
	python_execute_nosetests -P .
}

src_install() {
	newbin lib_users.py lib_users
	dodoc README TODO
}
