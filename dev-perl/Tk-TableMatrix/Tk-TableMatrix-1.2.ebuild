# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tk-TableMatrix/Tk-TableMatrix-1.2.ebuild,v 1.4 2005/08/26 00:32:26 agriffis Exp $

inherit perl-module eutils

DESCRIPTION="Perl module for Tk-TableMatrix"
HOMEPAGE="http://search.cpan.org/author/CERNEY/${P}"
SRC_URI="mirror://cpan/authors/id/C/CE/CERNEY/${P}.tar.gz"

#SRC_TEST="do"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/perl-tk
	!=perl-core/ExtUtils-MakeMaker-6.15"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/patch.diff
}
