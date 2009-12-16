# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ShipIt/ShipIt-0.53.ebuild,v 1.1 2009/12/16 19:11:00 tove Exp $

EAPI=2

MODULE_AUTHOR="BRADFITZ"
inherit perl-module

DESCRIPTION="Software Release Tool"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

SRC_TEST="do"

pkg_postinst() {
	elog "Please note that ShipIt does not depend on any specific VCS."
	elog "You must install a supported VCS (CVS, SVN, SVK, GIT, HG) for use."
}
