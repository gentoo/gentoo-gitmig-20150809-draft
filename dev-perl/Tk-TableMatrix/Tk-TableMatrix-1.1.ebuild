# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tk-TableMatrix/Tk-TableMatrix-1.1.ebuild,v 1.6 2004/10/19 08:06:55 absinthe Exp $

inherit perl-module eutils

DESCRIPTION="Perl module for Tk-TableMatrix"
HOMEPAGE="http://search.cpan.org/author/CERNEY/${P}"
SRC_URI="http://search.cpan.org/CPAN/authors/id/C/CE/CERNEY/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc alpha amd64"
IUSE=""

DEPEND="dev-perl/perl-tk
	!=dev-perl/ExtUtils-MakeMaker-6.15"

src_unpack() {
	unpack ${A}
	cd ${S}
	#epatch ${FILESDIR}/patch.diff
}
