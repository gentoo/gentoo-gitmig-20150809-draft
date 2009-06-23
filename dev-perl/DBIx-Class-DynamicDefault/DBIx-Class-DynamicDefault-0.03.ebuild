# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-Class-DynamicDefault/DBIx-Class-DynamicDefault-0.03.ebuild,v 1.2 2009/06/23 13:53:32 tove Exp $

EAPI=2

MODULE_AUTHOR=FLORA
inherit perl-module

DESCRIPTION="Automatically set and update fields"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/DBIx-Class-0.08009
	dev-perl/parent"
DEPEND="test? ( ${RDEPEND}
	dev-perl/DBICx-TestDatabase )"

SRC_TEST="do"
