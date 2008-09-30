# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Data-Inheritable/Class-Data-Inheritable-0.08.ebuild,v 1.3 2008/09/30 11:05:26 tove Exp $

MODULE_AUTHOR=TMTM
inherit perl-module

DESCRIPTION="Exception::Class module for perl"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha ~amd64 ia64 ~ppc ~ppc64 sparc x86"
IUSE=""

export OPTIMIZE="${CFLAGS}"
DEPEND="dev-lang/perl"
