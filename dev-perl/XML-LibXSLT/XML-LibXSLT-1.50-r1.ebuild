# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-LibXSLT/XML-LibXSLT-1.50-r1.ebuild,v 1.10 2006/07/05 13:31:25 ian Exp $

inherit perl-module

DESCRIPTION="A Perl module to parse XSL Transformational sheets using gnome's libXSLT"
SRC_URI="mirror://cpan/authors/id/M/MS/MSERGEANT/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~msergeant/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 alpha ppc sparc"
IUSE=""

DEPEND=">=dev-libs/libxslt-1.0.1
	>=dev-perl/XML-LibXML-1.49"
RDEPEND="${DEPEND}"