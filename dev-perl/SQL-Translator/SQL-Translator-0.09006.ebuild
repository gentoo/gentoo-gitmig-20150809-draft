# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SQL-Translator/SQL-Translator-0.09006.ebuild,v 1.1 2009/06/23 07:46:08 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="JROBINSON"

inherit perl-module

DESCRIPTION="Convert RDBMS SQL CREATE syntax."

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-perl/yaml-0.68
	dev-perl/Test-Exception
	>=dev-perl/IO-stringy-2.110
	dev-perl/Class-Base
	>=dev-perl/Digest-SHA1-2.12
	dev-perl/Class-Accessor
	>=dev-perl/Parse-RecDescent-1.96.0
	dev-perl/Test-Differences
	>=dev-perl/File-ShareDir-1.00
	dev-perl/Class-MakeMethods
	>=dev-perl/XML-Writer-0.606
	dev-perl/Carp-Clan
	dev-perl/Class-Data-Inheritable
	dev-perl/DBI"
RDEPEND="${DEPEND}"
