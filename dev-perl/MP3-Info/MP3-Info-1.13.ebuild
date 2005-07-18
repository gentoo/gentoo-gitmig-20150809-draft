# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MP3-Info/MP3-Info-1.13.ebuild,v 1.2 2005/07/18 11:46:14 mcummings Exp $

inherit perl-module

DESCRIPTION="A Perl module to manipulate/fetch info from MP3 files"
SRC_URI="mirror://cpan/authors/id/C/CN/CNANDOR/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~cnandor/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~ppc64 ~sparc ~alpha ~hppa ~ia64 ~mips"
IUSE=""

SRC_TEST="do"

