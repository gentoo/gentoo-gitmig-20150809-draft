# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MP3-Info/MP3-Info-1.02-r1.ebuild,v 1.3 2004/01/29 13:35:30 agriffis Exp $

inherit perl-module

S="${WORKDIR}/${P}"
DESCRIPTION="A Perl module to manipulate/fetch info from MP3 files"
SRC_URI="http://www.cpan.org/modules/by-authors/id/C/CN/CNANDOR/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/C/CN/CNANDOR/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc sparc alpha hppa ia64"

DEPEND="|| ( dev-perl/Test-Simple >=perl-5.8.0-r12 )"

