# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Unicode-Map8/Unicode-Map8-0.11-r1.ebuild,v 1.10 2006/08/06 00:51:48 mcummings Exp $

inherit perl-module

DESCRIPTION="A Unicode Perl Module"
SRC_URI="mirror://cpan/authors/id/G/GA/GAAS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~gaas/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND=">=dev-perl/Unicode-String-2.06
	dev-lang/perl"
RDEPEND="${DEPEND}"

mydoc="TODO"

