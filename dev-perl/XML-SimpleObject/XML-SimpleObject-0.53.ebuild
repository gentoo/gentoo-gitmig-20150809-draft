# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-SimpleObject/XML-SimpleObject-0.53.ebuild,v 1.13 2007/01/19 17:46:32 mcummings Exp $

inherit perl-module

VERSION=0.53
S=${WORKDIR}/XML-SimpleObject${VERSION}
DESCRIPTION="A Perl XML Simple package."
SRC_URI="mirror://cpan/authors/id/D/DB/DBRIAN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~dbrian/"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"

DEPEND=">=dev-perl/XML-Parser-2.30
	>=dev-perl/XML-LibXML-1.54
	dev-lang/perl"
