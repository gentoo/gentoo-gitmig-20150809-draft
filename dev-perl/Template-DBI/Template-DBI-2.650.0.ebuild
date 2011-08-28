# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Template-DBI/Template-DBI-2.650.0.ebuild,v 1.1 2011/08/28 18:27:28 tove Exp $

EAPI=4

MODULE_AUTHOR=REHSACK
MODULE_VERSION=2.65
inherit perl-module

DESCRIPTION="DBI plugin for the Template Toolkit"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-solaris"
IUSE="test"

RDEPEND=">=dev-perl/DBI-1.612
	>=dev-perl/Template-Toolkit-2.22"
DEPEND="${RDEPEND}
	test? (
		dev-perl/MLDBM
		>=dev-perl/SQL-Statement-1.28
	)"

SRC_TEST="do"
