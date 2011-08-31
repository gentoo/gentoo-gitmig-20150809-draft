# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-Class-DynamicDefault/DBIx-Class-DynamicDefault-0.30.0.ebuild,v 1.1 2011/08/31 13:42:37 tove Exp $

EAPI=4

MODULE_AUTHOR=FLORA
MODULE_VERSION=0.03
inherit perl-module

DESCRIPTION="Automatically set and update fields"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/DBIx-Class-0.08009
	virtual/perl-parent"
DEPEND="test? ( ${RDEPEND}
	dev-perl/DBICx-TestDatabase )"

SRC_TEST="do"
