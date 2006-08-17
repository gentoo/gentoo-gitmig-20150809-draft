# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Daemon/Net-Daemon-0.39.ebuild,v 1.7 2006/08/17 22:10:38 mcummings Exp $

inherit perl-module

DESCRIPTION="Abstract base class for portable servers"
HOMEPAGE="http://www.cpan.org/modules/by-module/Net/${P}.readme"
SRC_URI="mirror://cpan/authors/id/J/JW/JWIED/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ~ppc ~ppc64 s390 sh sparc ~x86 ~x86-fbsd"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
