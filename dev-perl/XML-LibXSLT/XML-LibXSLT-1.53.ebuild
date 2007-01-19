# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-LibXSLT/XML-LibXSLT-1.53.ebuild,v 1.13 2007/01/19 17:36:15 mcummings Exp $

inherit perl-module

DESCRIPTION="A Perl module to parse XSL Transformational sheets using gnome's libXSLT"
SRC_URI="mirror://cpan/authors/id/M/MS/MSERGEANT/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~msergeant/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 alpha ppc sparc ~mips"
IUSE=""

DEPEND=">=dev-libs/libxslt-1.0.1
	>=dev-perl/XML-LibXML-1.49
	dev-lang/perl"
