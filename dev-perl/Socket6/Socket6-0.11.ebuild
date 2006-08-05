# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Socket6/Socket6-0.11.ebuild,v 1.10 2006/08/05 20:32:57 mcummings Exp $

inherit perl-module

DESCRIPTION="IPv6 related part of the C socket.h defines and structure manipulators"
SRC_URI="http://search.cpan.org/CPAN/authors/id/U/UM/UMEMOTO/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/UMEMOTO/${P}/"

IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
