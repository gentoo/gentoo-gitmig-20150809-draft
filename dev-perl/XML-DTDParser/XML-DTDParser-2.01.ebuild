# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DTDParser/XML-DTDParser-2.01.ebuild,v 1.15 2007/08/27 14:10:06 armin76 Exp $

inherit perl-module

DESCRIPTION="Quick and dirty DTD Parser"
HOMEPAGE="http://search.cpan.org/~jenda/"
SRC_URI="mirror://cpan/authors/id/J/JE/JENDA/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
