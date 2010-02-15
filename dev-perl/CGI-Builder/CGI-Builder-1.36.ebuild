# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CGI-Builder/CGI-Builder-1.36.ebuild,v 1.2 2010/02/15 03:33:35 robbat2 Exp $

EAPI="2"

MODULE_AUTHOR="DOMIZIO"

inherit perl-module

DESCRIPTION="Framework to build simple or complex web-apps"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-perl/OOTools-2.21
	>=dev-perl/IO-Util-1.5"
RDEPEND="${DEPEND}"
