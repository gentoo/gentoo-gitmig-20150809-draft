# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Encoding/XML-Encoding-1.01-r2.ebuild,v 1.12 2006/07/05 13:19:50 ian Exp $

inherit perl-module

DESCRIPTION="Perl Module that parses encoding map XML files"
SRC_URI="mirror://cpan/authors/id/C/CO/COOPERCL/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~coopercl/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ~hppa ia64 ppc sparc x86"
IUSE=""

DEPEND=">=dev-perl/XML-Parser-2.29"
RDEPEND="${DEPEND}"