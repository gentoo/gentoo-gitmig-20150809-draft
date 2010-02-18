# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Multiplex/IO-Multiplex-1.10.ebuild,v 1.2 2010/02/18 20:31:19 darkside Exp $

MODULE_AUTHOR=BBB
inherit perl-module

DESCRIPTION="Manage IO on many file handles "

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
