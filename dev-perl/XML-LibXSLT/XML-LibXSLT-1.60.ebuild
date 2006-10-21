# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-LibXSLT/XML-LibXSLT-1.60.ebuild,v 1.4 2006/10/21 14:48:21 dertobi123 Exp $

inherit perl-module

DESCRIPTION="A Perl module to parse XSL Transformational sheets using gnome's libXSLT"
SRC_URI="mirror://cpan/authors/id/P/PA/PAJAS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~pajas/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha amd64 ia64 ppc ~ppc64 sparc ~x86"
IUSE=""

# Disabled for now. The tests generate errors on threaded perls due
# to returns coming back out of sequence.
#SRC_TEST="do"

DEPEND=">=dev-libs/libxslt-1.1.2
	>=dev-perl/XML-LibXML-1.60
	dev-lang/perl"
