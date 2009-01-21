# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-BufferedSelect/IO-BufferedSelect-1.0.ebuild,v 1.5 2009/01/21 15:54:20 fmccor Exp $

inherit perl-module

DESCRIPTION="Perl module that implements a line-buffered select interface"
HOMEPAGE="http://search.cpan.org/~afn/IO-BufferedSelect-1.0/"
SRC_URI="mirror://cpan/authors/id/A/AF/AFN/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc x86"
IUSE=""

DEPEND="dev-lang/perl"

S="${WORKDIR}/${P/-${PV}}"
