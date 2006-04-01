# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rlcompleter2/rlcompleter2-0.96.ebuild,v 1.2 2006/04/01 19:03:07 agriffis Exp $

inherit distutils

DESCRIPTION="Python command line completion."
HOMEPAGE="http://codespeak.net/rlcompleter2/"
SRC_URI="http://codespeak.net/rlcompleter2/download/${P}.tar.gz"

LICENSE="PSF-2.2"
SLOT="0"
KEYWORDS="~ia64 ~ppc ~x86"
IUSE=""

DOCS="PKG-INFO"

pkg_postinst() {
	ewarn "Please read the README, and follow instructions in order to"
	ewarn "execute and configure rlcompleter2."
}
