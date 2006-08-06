# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DTDParser/XML-DTDParser-2.01.ebuild,v 1.11 2006/08/06 01:19:49 mcummings Exp $

inherit perl-module

DESCRIPTION="Quick and dirty DTD Parser"
HOMEPAGE="http://search.cpan.org/~jenda/${P}/"
SRC_URI="mirror://cpan/authors/id/J/JE/JENDA/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 hppa ia64 ppc sparc x86"
IUSE=""

SRC_TEST="do"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
