# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-HTMLDoc/HTML-HTMLDoc-0.10.ebuild,v 1.6 2006/08/07 23:28:40 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl interface to the htmldoc program for producing PDF-Files from HTML-Content"
HOMEPAGE="http://search.cpan.org/~mkfrankl/${P}/"
SRC_URI="mirror://cpan/authors/id/M/MF/MFRANKL/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="app-text/htmldoc
	dev-lang/perl"
RDEPEND="${DEPEND}"

