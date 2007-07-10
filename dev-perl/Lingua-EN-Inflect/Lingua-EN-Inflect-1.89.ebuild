# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-EN-Inflect/Lingua-EN-Inflect-1.89.ebuild,v 1.10 2007/07/10 23:33:26 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="Perl module for Lingua::EN::Inflect"
SRC_URI="mirror://cpan/authors/id/D/DC/DCONWAY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~dconway/"
SRC_TEST="do"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="dev-lang/perl"
