# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SNPP/Net-SNPP-1.17.ebuild,v 1.4 2004/07/14 19:49:34 agriffis Exp $

inherit perl-module

DESCRIPTION="libnet SNPP component"
SRC_URI="http://search.cpan.org/CPAN/authors/id/T/TO/TOBEYA/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~tobeya/${P}/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="dev-perl/libnet"
