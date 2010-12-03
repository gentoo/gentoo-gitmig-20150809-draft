# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SQL-Translator/SQL-Translator-0.11007.ebuild,v 1.1 2010/12/03 07:48:12 tove Exp $

EAPI=3

MODULE_AUTHOR="RIBASUSHI"
MODULE_AUTHOR=JROBINSON
inherit perl-module

DESCRIPTION="Convert RDBMS SQL CREATE syntax"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/yaml-0.68
	>=dev-perl/IO-stringy-2.110
	dev-perl/Class-Base
	>=dev-perl/Digest-SHA1-2.12
	dev-perl/Class-Accessor
	>=dev-perl/Parse-RecDescent-1.962.2
	>=dev-perl/File-ShareDir-1.00
	dev-perl/Class-MakeMethods
	>=dev-perl/XML-Writer-0.606
	dev-perl/Carp-Clan
	dev-perl/Class-Data-Inheritable
	dev-perl/DBI"
DEPEND="${RDEPEND}
	test? (
		dev-perl/HTML-Parser
		>=dev-perl/XML-LibXML-1.69
		dev-perl/Spreadsheet-ParseExcel
		>=dev-perl/Template-Toolkit-2.2
		dev-perl/Test-Exception
		dev-perl/Test-Differences
		dev-perl/Test-Pod
	)"

SRC_TEST=do
