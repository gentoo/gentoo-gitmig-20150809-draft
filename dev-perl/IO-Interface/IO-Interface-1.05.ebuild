# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Interface/IO-Interface-1.05.ebuild,v 1.1 2008/09/05 13:53:44 tove Exp $

MODULE_AUTHOR=LDS
inherit perl-module

DESCRIPTION="Perl extension for access to network card configuration information"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"
