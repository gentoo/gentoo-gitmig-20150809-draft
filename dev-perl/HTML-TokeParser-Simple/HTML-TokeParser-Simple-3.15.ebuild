# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-TokeParser-Simple/HTML-TokeParser-Simple-3.15.ebuild,v 1.11 2008/04/22 20:04:20 tove Exp $

inherit perl-module

DESCRIPTION="A bare-bones HTML parser, similar to HTML::Parser, but with a couple important distinctions."
HOMEPAGE="http://search.cpan.org/~ovid/"
SRC_URI="mirror://cpan/authors/id/O/OV/OVID/${P}.tar.gz"
IUSE=""
LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86"

SRC_TEST="do"

RDEPEND=">=dev-perl/HTML-Parser-3.25
	dev-lang/perl"
DEPEND="${RDEPEND}
	dev-perl/module-build
	virtual/perl-Test-Simple
	dev-perl/Sub-Override"
