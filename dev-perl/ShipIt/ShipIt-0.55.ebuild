# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ShipIt/ShipIt-0.55.ebuild,v 1.1 2010/03/27 21:48:04 robbat2 Exp $

EAPI=2

MODULE_AUTHOR="BRADFITZ"
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
