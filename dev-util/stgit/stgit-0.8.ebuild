# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/stgit/stgit-0.8.ebuild,v 1.1 2005/12/23 15:40:14 ferdy Exp $

inherit distutils

DESCRIPTION="Manage a stack of patches using GIT as a backend"
HOMEPAGE="http://www.procode.org/stgit/"
SRC_URI="http://homepage.ntlworld.com/cmarinas/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha"
IUSE=""

DEPEND=""
RDEPEND=">=dev-util/git-0.99"

src_install() {
	sed -i -e 's-\(prefix:\) ~-\1 /usr-' setup.cfg
	distutils_src_install
	dodir /usr/share/doc/${PF}
	mv ${D}/usr/share/${PN}/examples ${D}/usr/share/doc/${PF}
	rmdir ${D}/usr/share/doc/${PN}
}
