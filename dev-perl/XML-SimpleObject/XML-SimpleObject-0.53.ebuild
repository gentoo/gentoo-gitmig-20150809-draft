# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-SimpleObject/XML-SimpleObject-0.53.ebuild,v 1.9 2005/08/26 02:35:54 agriffis Exp $

inherit perl-module

VERSION=0.53
S=${WORKDIR}/XML-SimpleObject${VERSION}
DESCRIPTION="A Perl XML Simple package."
SRC_URI="mirror://cpan/authors/id/D/DB/DBRIAN/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/XML/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"

DEPEND="${DEPEND}
	>=dev-perl/XML-Parser-2.30
	>=dev-perl/XML-LibXML-1.54"

