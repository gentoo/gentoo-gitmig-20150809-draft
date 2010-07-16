# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-EN-NameParse/Lingua-EN-NameParse-1.27.ebuild,v 1.1 2010/07/16 06:25:34 tove Exp $

EAPI=3

MODULE_AUTHOR=KIMRYAN
inherit perl-module

DESCRIPTION="Manipulate persons name"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-perl/Parse-RecDescent"
DEPEND="${RDEPEND}"

SRC_TEST="do"
