# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tk-TableMatrix/Tk-TableMatrix-1.1.ebuild,v 1.11 2006/05/01 22:15:16 mcummings Exp $

inherit perl-module eutils

DESCRIPTION="Perl module for Tk-TableMatrix"
HOMEPAGE="http://search.cpan.org/author/CERNEY/${P}"
SRC_URI="mirror://cpan/authors/id/C/CE/CERNEY/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ~ppc sparc alpha amd64"
IUSE=""

DEPEND="dev-perl/perl-tk
	!=perl-core/ExtUtils-MakeMaker-6.15"

src_unpack() {
	unpack ${A}
	cd ${S}
	#epatch ${FILESDIR}/patch.diff
}
