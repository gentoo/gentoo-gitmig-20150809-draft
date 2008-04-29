# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Encoding/XML-Encoding-2.01.ebuild,v 1.1 2008/04/29 00:17:38 yuval Exp $

inherit perl-module

DESCRIPTION="Perl Module that parses encoding map XML files"
SRC_URI="mirror://cpan/authors/id/S/SH/SHAY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~coopercl/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/XML-Parser
	dev-lang/perl"
