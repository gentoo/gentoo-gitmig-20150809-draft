# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-Tiny/Config-Tiny-2.10.ebuild,v 1.7 2007/07/05 14:37:18 armin76 Exp $

inherit perl-module

DESCRIPTION="Read/Write .ini style files with as little code as possible"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~adamk/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ppc ~ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="virtual/perl-Test-Simple
	dev-lang/perl"
