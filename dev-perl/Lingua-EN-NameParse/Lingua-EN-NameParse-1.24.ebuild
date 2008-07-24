# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-EN-NameParse/Lingua-EN-NameParse-1.24.ebuild,v 1.1 2008/07/24 11:20:27 tove Exp $

MODULE_AUTHOR=KIMRYAN
inherit perl-module

DESCRIPTION="Manipulate persons name"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

DEPEND="dev-perl/Parse-RecDescent
	dev-lang/perl"

SRC_TEST="do"
