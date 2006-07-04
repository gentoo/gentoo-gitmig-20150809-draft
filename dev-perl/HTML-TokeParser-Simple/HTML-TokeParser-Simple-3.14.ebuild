# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-TokeParser-Simple/HTML-TokeParser-Simple-3.14.ebuild,v 1.6 2006/07/04 10:20:54 ian Exp $

inherit perl-module

DESCRIPTION="A bare-bones HTML parser, similar to HTML::Parser, but with a couple important distinctions."
HOMEPAGE="http://www.cpan.org/modules/by-module/HTML/HTML-TokeParser-Simple-3.14.readme"
SRC_URI="mirror://cpan/authors/id/O/OV/OVID/${P}.tar.gz"
IUSE=""
LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"

SRC_TEST="do"

DEPEND=">=dev-perl/HTML-Parser-3.25
		virtual/perl-Test-Simple
		dev-perl/Sub-Override"
RDEPEND="${DEPEND}"