# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Page/Data-Page-2.01.ebuild,v 1.1 2009/06/23 07:38:01 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="LBROCARD"

inherit perl-module

DESCRIPTION="help when paging through sets of results"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/Class-Accessor-Chained
	dev-perl/Test-Exception"
RDEPEND="${DEPEND}"
