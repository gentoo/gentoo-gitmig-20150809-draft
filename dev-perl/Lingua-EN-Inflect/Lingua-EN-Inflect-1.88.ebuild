# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-EN-Inflect/Lingua-EN-Inflect-1.88.ebuild,v 1.12 2006/08/05 13:23:17 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl module for Lingua::EN::Inflect"
SRC_URI="mirror://cpan/authors/id/D/DC/DCONWAY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/DCONWAY/Lingua-EN-Inflect-1.88/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
