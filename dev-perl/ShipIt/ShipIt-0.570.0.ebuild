# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ShipIt/ShipIt-0.570.0.ebuild,v 1.1 2012/07/24 15:53:15 tove Exp $

EAPI=4

MODULE_AUTHOR=MIYAGAWA
MODULE_VERSION=0.57
inherit perl-module

DESCRIPTION="Software Release Tool"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

SRC_TEST="do"

pkg_postinst() {
	elog "Please note that ShipIt does not depend on any specific VCS."
	elog "You must install a supported VCS (CVS, SVN, SVK, GIT, HG) for use."
}
