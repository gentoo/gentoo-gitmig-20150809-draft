# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/rlcompleter2/rlcompleter2-0.95.ebuild,v 1.1 2003/03/30 00:39:19 kutsuya Exp $

inherit distutils

DESCRIPTION="Python command line completion."
HOMEPAGE="http://codespeak.net/rlcompleter2/"
SRC_URI="${HOMEPAGE}download/${P}.tar.gz"
SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="PSF-2.2"
IUSE=""

src_install()
{
	mydoc="PKG-INFO ${mydoc}"
	distutils_src_install
}

pkg_postinst()
{
	ewarn "Please read the README, and follow instructions in order to"
	ewarn "execute and configure rlcompleter2."
}
