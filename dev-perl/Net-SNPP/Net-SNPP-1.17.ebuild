# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SNPP/Net-SNPP-1.17.ebuild,v 1.5 2004/10/16 23:57:22 rac Exp $

inherit perl-module

DESCRIPTION="libnet SNPP component"
SRC_URI="http://search.cpan.org/CPAN/authors/id/T/TO/TOBEYA/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~tobeya/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="dev-perl/libnet"
