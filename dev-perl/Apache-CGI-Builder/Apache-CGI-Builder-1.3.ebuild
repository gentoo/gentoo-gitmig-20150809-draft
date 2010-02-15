# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-CGI-Builder/Apache-CGI-Builder-1.3.ebuild,v 1.2 2010/02/15 03:33:46 robbat2 Exp $

EAPI="2"

MODULE_AUTHOR="DOMIZIO"

inherit perl-module

DESCRIPTION="CGI::Builder and Apache/mod_perl (1 and 2) integration"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-perl/OOTools-2.21
	>=dev-perl/CGI-Builder-1.2"
RDEPEND="${DEPEND}"
