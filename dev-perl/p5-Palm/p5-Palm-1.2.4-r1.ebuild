# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/p5-Palm/p5-Palm-1.2.4-r1.ebuild,v 1.6 2004/02/27 15:52:00 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl Module for Palm Pilots"
SRC_URI="http://www.cpan.org/authors/id/A/AR/ARENSB/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/doc/ARENSB/${P}/README"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="${DEPEND}"
