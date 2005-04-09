# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-LinkExtractor/HTML-LinkExtractor-0.12.1.ebuild,v 1.3 2005/04/09 02:05:34 gustavoz Exp $

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
KEYWORDS="~x86 sparc ~amd64 ~ppc ~ppc64"

DEPEND="dev-perl/HTML-Parser"
