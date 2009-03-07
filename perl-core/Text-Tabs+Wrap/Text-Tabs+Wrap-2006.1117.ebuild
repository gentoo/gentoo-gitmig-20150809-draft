# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Text-Tabs+Wrap/Text-Tabs+Wrap-2006.1117.ebuild,v 1.1 2009/03/07 10:02:26 tove Exp $

MODULE_AUTHOR=MUIR
MODULE_SECTION=modules
inherit perl-module

DESCRIPTION="Expand/unexpand tabs per unix expand and line wrapping"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
SRC_TEST="do"

DEPEND="dev-lang/perl"
