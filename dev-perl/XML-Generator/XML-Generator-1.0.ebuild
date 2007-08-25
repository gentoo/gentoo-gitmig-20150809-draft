# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Generator/XML-Generator-1.0.ebuild,v 1.6 2007/08/25 13:17:24 vapier Exp $

inherit perl-module

DESCRIPTION="Perl XML::Generator - A module to help in generating XML documents"
HOMEPAGE="http://www.cpan.org/authors/id/B/BH/BHOLZMAN/"
SRC_URI="mirror://cpan/authors/id/B/BH/BHOLZMAN/${P}.tar.gz"

LICENSE="|| ( GPL-2 Artistic )"
SLOT="0"
KEYWORDS="alpha ~amd64 arm ~hppa ia64 ~mips ppc ~ppc64 s390 sh sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-libs/expat
	dev-lang/perl"
RDEPEND="${DEPEND}"
