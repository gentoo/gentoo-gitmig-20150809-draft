# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PodToHTML/PodToHTML-0.05.ebuild,v 1.5 2006/07/03 12:05:10 ian Exp $

inherit perl-module

DESCRIPTION="convert POD documentation to HTML"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/N/NI/NI-S/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ia64 sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/HTML-Tree
		dev-perl/HTML-Parser
		dev-perl/HTML-Format"
RDEPEND="${DEPEND}"
