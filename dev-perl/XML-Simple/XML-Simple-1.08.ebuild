# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Simple/XML-Simple-1.08.ebuild,v 1.17 2005/01/04 14:26:26 mcummings Exp $

inherit perl-module

DESCRIPTION="A Perl XML Simple package."
SRC_URI="mirror://cpan/authors/id/G/GR/GRANTM/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~grantm/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND="${DEPEND}
	>=dev-perl/XML-Parser-2.30"
