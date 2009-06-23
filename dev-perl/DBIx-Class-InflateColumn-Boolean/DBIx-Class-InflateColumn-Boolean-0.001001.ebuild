# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-Class-InflateColumn-Boolean/DBIx-Class-InflateColumn-Boolean-0.001001.ebuild,v 1.1 2009/06/23 07:36:44 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="GRAF"

inherit perl-module

DESCRIPTION="Auto-create boolean objects from columns"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/SQL-Translator
	dev-perl/Path-Class
	>=dev-perl/DBIx-Class-0.08107
	dev-perl/Contextual-Return"
RDEPEND="${DEPEND}"
