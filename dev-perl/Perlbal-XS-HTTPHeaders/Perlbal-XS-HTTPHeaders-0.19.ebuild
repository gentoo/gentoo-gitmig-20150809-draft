# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Perlbal-XS-HTTPHeaders/Perlbal-XS-HTTPHeaders-0.19.ebuild,v 1.2 2007/05/09 08:51:42 robbat2 Exp $

inherit perl-module

DESCRIPTION="XS acceleration for Perlbal header processing"
HOMEPAGE="http://search.cpan.org/search?query=Perlbal-XS-HTTPHeaders&mode=dist"
SRC_URI="mirror://cpan/authors/id/M/MA/MARKSMITH/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="dev-perl/Perlbal
		dev-lang/perl"
mydoc="Changes README"
