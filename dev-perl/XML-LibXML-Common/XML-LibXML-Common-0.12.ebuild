# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header $

IUSE=""

inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="Routines and Constants common for XML::LibXML and XML::GDOME." 
SRC_URI="http://search.cpan.org/CPAN/authors/id/P/PH/PHISH/${P}.tar.gz"
HOMEPAGE="http:/search.cpan.org/src/ILYAZ/Term-ReadLine-Perl-1.0203/README"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND="${DEPEND}
	>=dev-libs/libxml2-2.4.1"
