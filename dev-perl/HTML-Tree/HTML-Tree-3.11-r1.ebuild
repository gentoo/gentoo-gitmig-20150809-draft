# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Manteiner: José Alberto Suárez López <bass@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Tree/HTML-Tree-3.11-r1.ebuild,v 1.4 2003/02/13 11:10:06 vapier Exp $ 

inherit perl-module

MY_P=HTML-Tree-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A library to manage HTML-Tree in PERL"
SRC_URI="http://www.perl.com/CPAN/authors/id/S/SB/SBURKE/${P}.tar.gz"
HOMEPAGE="http://www.perl.com/CPAN/authors/id/S/SB/SBURKE/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc sparc alpha"

mydoc="Changes MANIFEST README"
DEPEND=">=dev-perl/HTML-Tagset-3.03 "
