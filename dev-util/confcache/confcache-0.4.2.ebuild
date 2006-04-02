# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/confcache/confcache-0.4.2.ebuild,v 1.5 2006/04/02 20:57:21 weeve Exp $

inherit distutils

DESCRIPTION="global autoconf cache manager"
HOMEPAGE="http://gentooexperimental.org/~ferringb/confcache/"
SRC_URI="http://gentooexperimental.org/~ferringb/confcache/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""
DEPEND=">=dev-lang/python-2.2"
RDEPEND=">=dev-lang/python-2.2 >=sys-apps/sandbox-1.2.12"

src_install() {
	distutils_src_install
	rm -rf "${D}/usr/share/doc/confcache"
}
