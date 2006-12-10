# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SNPP/Net-SNPP-1.17.ebuild,v 1.17 2006/12/10 11:48:57 yuval Exp $

inherit perl-module

DESCRIPTION="libnet SNPP component"
SRC_URI="mirror://cpan/authors/id/T/TO/TOBEYA/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~tobeya/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND="virtual/perl-libnet
	dev-lang/perl"
RDEPEND="${DEPEND}"

