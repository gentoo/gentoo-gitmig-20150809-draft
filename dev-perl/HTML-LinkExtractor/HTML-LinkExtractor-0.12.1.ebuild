# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-LinkExtractor/HTML-LinkExtractor-0.12.1.ebuild,v 1.9 2006/12/05 22:49:42 yuval Exp $

inherit perl-module

MY_PV=${PV/2.1/21}
MY_P="${PN}-${MY_PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A bare-bones HTML parser, similar to HTML::Parser, but with a couple important distinctions."
HOMEPAGE="http://www.cpan.org/modules/by-module/HTML/${P}.readme"
SRC_URI="mirror://cpan/authors/id/P/PO/PODMASTER/${MY_P}.tar.gz"
IUSE=""
LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 sparc x86"

DEPEND="dev-perl/HTML-Parser
	dev-lang/perl"
RDEPEND="${DEPEND}
	dev-perl/URI"


