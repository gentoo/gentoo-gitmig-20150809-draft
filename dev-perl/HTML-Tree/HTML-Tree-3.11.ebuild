# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Manteiner: José Alberto Suárez López <bass@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Tree/HTML-Tree-3.11.ebuild,v 1.4 2002/07/25 04:13:26 seemant Exp $ 

inherit perl-module

MY_P=HTML-Tree-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A library to manage HTML-Tree in PERL"
SRC_URI="http://www.perl.com/CPAN/authors/id/S/SB/SBURKE/${P}.tar.gz"
HOMEPAGE="http://www.perl.com/CPAN/authors/id/S/SB/SBURKE/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86"

mydoc="Changes MANIFEST README"
DEPEND=">=dev-perl/HTML-Tagset-3.03 "
