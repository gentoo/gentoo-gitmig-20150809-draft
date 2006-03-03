# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/confcache/confcache-0.4.2.ebuild,v 1.2 2006/03/03 23:47:27 hansmi Exp $

inherit distutils

DESCRIPTION="global autoconf cache manager"
HOMEPAGE="http://dev.gentoo.org/~ferringb/${PN}"
SRC_URI="http://dev.gentoo.org/~ferringb/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE=""
DEPEND=">=dev-lang/python-2.2"
RDEPEND=">=dev-lang/python-2.2 >=sys-apps/sandbox-1.2.12"

src_install() {
	distutils_src_install
	rm -rf "${D}/usr/share/doc/confcache"
}
