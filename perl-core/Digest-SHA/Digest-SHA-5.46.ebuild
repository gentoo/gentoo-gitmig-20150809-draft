# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Digest-SHA/Digest-SHA-5.46.ebuild,v 1.4 2008/12/08 16:42:15 armin76 Exp $

MODULE_AUTHOR=MSHELOR

inherit perl-module

DESCRIPTION="Perl extension for SHA-1/224/256/384/512"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
