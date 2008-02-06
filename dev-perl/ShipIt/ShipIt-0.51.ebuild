# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ShipIt/ShipIt-0.51.ebuild,v 1.1 2008/02/06 02:48:15 robbat2 Exp $

MODULE_AUTHOR="BRADFITZ"
inherit perl-module

DESCRIPTION="Software Release Tool"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86 ~ppc"
SRC_TEST="do"

pkg_postinst() {
	elog "Please note that ShipIt does not depend on any specific VCS." 
	elog "You must install a supported VCS (CVS, SVN, SVK) for use."
}
