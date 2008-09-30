# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SQL-Statement/SQL-Statement-1.15.ebuild,v 1.9 2008/09/30 14:49:47 tove Exp $

MODULE_AUTHOR=JZUCKER
inherit perl-module

DESCRIPTION="Small SQL parser and engine"

IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ia64 sparc x86"

SRC_TEST="do"

DEPEND="dev-lang/perl"
