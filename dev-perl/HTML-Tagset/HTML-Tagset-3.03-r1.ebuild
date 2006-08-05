# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Tagset/HTML-Tagset-3.03-r1.ebuild,v 1.16 2006/08/05 04:29:47 mcummings Exp $

inherit perl-module

DESCRIPTION="A HTML tagset Perl Module"
SRC_URI="mirror://cpan/authors/id/S/SB/SBURKE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~sburke/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
