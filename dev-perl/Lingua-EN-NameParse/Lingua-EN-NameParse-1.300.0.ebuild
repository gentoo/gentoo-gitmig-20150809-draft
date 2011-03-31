# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-EN-NameParse/Lingua-EN-NameParse-1.300.0.ebuild,v 1.1 2011/03/31 06:22:56 tove Exp $

EAPI=4

MODULE_AUTHOR=KIMRYAN
MODULE_VERSION=1.30
inherit perl-module

DESCRIPTION="Manipulate persons name"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="test"

RDEPEND="dev-perl/Parse-RecDescent"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
