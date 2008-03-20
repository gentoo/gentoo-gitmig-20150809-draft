# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyelemental/pyelemental-1.2.0.ebuild,v 1.2 2008/03/20 19:59:48 drac Exp $

inherit distutils

DESCRIPTION="python bindings for libelemental (sci-chemistry/gelemental)"
HOMEPAGE="http://www.kdau.com/projects/gelemental"
SRC_URI="http://www.kdau.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=sci-chemistry/gelemental-1.2.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS NEWS"

src_install() {
	distutils_src_install
	dohtml docs/html/*.html
}
