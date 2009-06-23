# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-Class-InflateColumn-Object-Enum/DBIx-Class-InflateColumn-Object-Enum-0.04.ebuild,v 1.1 2009/06/23 07:37:15 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="JMMILLS"
MODULE_A="${P}.tgz"

inherit perl-module

DESCRIPTION="Allows a DBIx::Class user to define a Object::Enum column"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/DBIx-Class
	dev-perl/Object-Enum
	dev-perl/DBICx-TestDatabase"
RDEPEND="${DEPEND}"
