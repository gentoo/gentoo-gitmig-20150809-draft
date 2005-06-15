# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SNPP/Net-SNPP-1.17.ebuild,v 1.8 2005/06/15 17:45:17 gustavoz Exp $

inherit perl-module

DESCRIPTION="libnet SNPP component"
SRC_URI="mirror://cpan/authors/id/T/TO/TOBEYA/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~tobeya/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~ppc sparc"
IUSE=""

DEPEND="dev-perl/libnet"
