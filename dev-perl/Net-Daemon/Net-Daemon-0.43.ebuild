# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Daemon/Net-Daemon-0.43.ebuild,v 1.7 2007/08/25 13:17:23 vapier Exp $

inherit perl-module

S=${WORKDIR}/${PN}

DESCRIPTION="Abstract base class for portable servers"
HOMEPAGE="http://search.cpan.org/~mnooning/"
SRC_URI="mirror://cpan/authors/id/M/MN/MNOONING/${PN}/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha ~amd64 arm ~hppa ia64 m68k mips ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/perl"
