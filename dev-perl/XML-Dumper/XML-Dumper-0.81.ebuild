# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Dumper/XML-Dumper-0.81.ebuild,v 1.10 2007/03/05 12:39:31 ticho Exp $

inherit perl-module

DESCRIPTION="Perl module for dumping Perl objects from/to XML"
SRC_URI="mirror://cpan/authors/id/M/MI/MIKEWONG/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~mikewong/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 hppa ia64 ~ppc sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND=">=dev-perl/XML-Parser-2.16
	dev-lang/perl"
