# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Daemon/Net-Daemon-0.39.ebuild,v 1.13 2007/07/10 23:33:26 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="Abstract base class for portable servers"
HOMEPAGE="http://search.cpan.org/~jwied/"
SRC_URI="mirror://cpan/authors/id/J/JW/JWIED/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/perl"
