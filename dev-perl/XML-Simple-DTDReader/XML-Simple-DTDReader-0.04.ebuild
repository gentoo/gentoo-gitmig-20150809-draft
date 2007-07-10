# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Simple-DTDReader/XML-Simple-DTDReader-0.04.ebuild,v 1.2 2007/07/10 23:33:29 mr_bones_ Exp $

inherit perl-module

S=${WORKDIR}/XML-Simple-DTDReader-0.04

DESCRIPTION="No description available"
HOMEPAGE="http://search.cpan.org/search?query=XML-Simple-DTDReader&mode=dist"
SRC_URI="mirror://cpan/authors/id/A/AL/ALEXMV/XML-Simple-DTDReader-0.04.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86"

DEPEND=">=dev-perl/XML-Parser-2.34
	dev-lang/perl"
