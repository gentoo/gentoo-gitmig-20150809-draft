# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Object-Enum/Object-Enum-0.072.ebuild,v 1.1 2009/06/23 07:44:48 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="HDP"

inherit perl-module

DESCRIPTION="replacement for if (\$foo eq 'bar')"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/Sub-Install
	dev-perl/Sub-Exporter
	dev-perl/Class-Data-Inheritable
	dev-perl/Class-Accessor"
RDEPEND="${DEPEND}"
