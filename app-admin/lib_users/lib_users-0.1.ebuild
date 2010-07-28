# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/lib_users/lib_users-0.1.ebuild,v 1.1 2010/07/28 13:14:59 jer Exp $

EAPI=3

DESCRIPTION="goes through /proc/*/maps and finds all cases of libraries being
mapped but marked as deleted"
HOMEPAGE="http://schwarzvogel.de/software-misc.shtml"
SRC_URI="http://schwarzvogel.de/pkgs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_test() {
	python test_libusers.py || echo "test failed"
}

src_install() {
	newsbin lib_users.py lib_users
	dodoc README TODO
}
