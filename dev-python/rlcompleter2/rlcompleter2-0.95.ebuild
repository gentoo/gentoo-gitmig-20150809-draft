# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rlcompleter2/rlcompleter2-0.95.ebuild,v 1.8 2004/05/04 12:37:09 kloeri Exp $

inherit distutils

DESCRIPTION="Python command line completion."
HOMEPAGE="http://codespeak.net/rlcompleter2/"
SRC_URI="http://codespeak.net/rlcompleter2/download/${P}.tar.gz"

LICENSE="PSF-2.2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DOCS="PKG-INFO"

pkg_postinst() {
	ewarn "Please read the README, and follow instructions in order to"
	ewarn "execute and configure rlcompleter2."
}
