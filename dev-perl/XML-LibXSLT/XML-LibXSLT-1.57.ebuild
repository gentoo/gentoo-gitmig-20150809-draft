# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-LibXSLT/XML-LibXSLT-1.57.ebuild,v 1.5 2005/03/22 19:07:06 mcummings Exp $

inherit perl-module

DESCRIPTION="A Perl module to parse XSL Transformational sheets using gnome's libXSLT"
SRC_URI="mirror://cpan/authors/id/M/MS/MSERGEANT/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~msergeant/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~alpha ~ppc ~sparc"
IUSE=""

# Disabled for now. The tests generate errors on threaded perls due
# to returns coming back out of sequence.
#SRC_TEST="do"

DEPEND="${DEPEND}
	>=dev-libs/libxslt-1.1.2
	>=dev-perl/XML-LibXML-1.58"
