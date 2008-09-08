# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-ReadLine-Gnu/Term-ReadLine-Gnu-1.17a.ebuild,v 1.1 2008/09/08 07:08:40 tove Exp $

MODULE_AUTHOR=HAYASHI
inherit perl-module

S=${WORKDIR}/${P/%a}

DESCRIPTION="GNU Readline XS library wrapper"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""
#SRC_TEST="do"

DEPEND="sys-libs/readline
		dev-lang/perl"
