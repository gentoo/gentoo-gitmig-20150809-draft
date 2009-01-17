# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-TableContentParser/HTML-TableContentParser-0.13.ebuild,v 1.4 2009/01/17 22:29:20 robbat2 Exp $

inherit perl-module

S=${WORKDIR}/HTML-TableContentParser-0.13

DESCRIPTION="No description available"
HOMEPAGE="http://search.cpan.org/search?query=HTML-TableContentParser&mode=dist"
SRC_URI="mirror://cpan/authors/id/S/SD/SDRABBLE/HTML-TableContentParser-0.13.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
