# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-FromText/HTML-FromText-2.05.ebuild,v 1.9 2005/05/25 04:21:08 vapier Exp $

inherit perl-module

DESCRIPTION="Convert plain text to HTML."
HOMEPAGE="http://search.cpan.org/~cwest/${P}/"
SRC_URI="mirror://cpan/authors/id/C/CW/CWEST/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/HTML-Parser
	dev-perl/Test-Simple
	dev-perl/Exporter-Lite
	>=dev-perl/Scalar-List-Utils-1.14
	dev-perl/Email-Find"
