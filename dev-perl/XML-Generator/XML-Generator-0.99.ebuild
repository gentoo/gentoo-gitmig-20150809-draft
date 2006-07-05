# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Generator/XML-Generator-0.99.ebuild,v 1.21 2006/07/05 13:24:57 ian Exp $

inherit perl-module

DESCRIPTION="Perl XML::Generator - A module to help in generating XML documents"
HOMEPAGE="http://www.cpan.org/authors/id/B/BH/BHOLZMAN/"
SRC_URI="mirror://cpan/authors/id/B/BH/BHOLZMAN/${P}.tar.gz"

LICENSE="|| ( GPL-2 Artistic )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-libs/expat"
RDEPEND="${DEPEND}"
