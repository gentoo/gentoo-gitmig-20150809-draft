# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/p5-Palm/p5-Palm-1.2.4-r1.ebuild,v 1.11 2006/08/06 02:57:59 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl Module for Palm Pilots"
SRC_URI="mirror://cpan/authors/id/A/AR/ARENSB/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/doc/ARENSB/${P}/README"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
