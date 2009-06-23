# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-Class-DynamicDefault/DBIx-Class-DynamicDefault-0.03.ebuild,v 1.1 2009/06/23 07:36:29 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="FLORA"

inherit perl-module

DESCRIPTION="Automatically set and update fields"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/parent
	>=dev-perl/DBIx-Class-0.08107
	dev-perl/DBICx-TestDatabase"
RDEPEND="${DEPEND}"
