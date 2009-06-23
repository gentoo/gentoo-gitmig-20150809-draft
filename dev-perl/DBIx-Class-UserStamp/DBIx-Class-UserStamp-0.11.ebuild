# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-Class-UserStamp/DBIx-Class-UserStamp-0.11.ebuild,v 1.1 2009/06/23 07:37:31 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="JGOULAH"

inherit perl-module

DESCRIPTION="Automatically set update and create user id fields"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/Class-Accessor-Grouped
	dev-perl/DBIx-Class-DynamicDefault
	dev-perl/DBIx-Class"
RDEPEND="${DEPEND}"
