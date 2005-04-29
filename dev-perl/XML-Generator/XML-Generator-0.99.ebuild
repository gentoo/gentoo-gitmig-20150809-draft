# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Generator/XML-Generator-0.99.ebuild,v 1.16 2005/04/29 15:54:50 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl XML::Generator - A module to help in generating XML documents"
HOMEPAGE="http://www.cpan.org/authors/id/B/BH/BHOLZMAN/"
SRC_URI="mirror://cpan/authors/id/B/BH/BHOLZMAN/${P}.tar.gz"

LICENSE="|| ( GPL-2 Artistic )"
SLOT="0"
KEYWORDS="sparc x86 ppc amd64 s390 hppa ppc64 ~mips alpha"
IUSE=""
SRC_TEST="do"

DEPEND="dev-libs/expat"
