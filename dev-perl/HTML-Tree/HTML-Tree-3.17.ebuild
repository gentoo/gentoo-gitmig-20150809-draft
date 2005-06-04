# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Tree/HTML-Tree-3.17.ebuild,v 1.6 2005/06/04 04:18:12 mcummings Exp $

inherit perl-module

MY_P=HTML-Tree-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A library to manage HTML-Tree in PERL"
SRC_URI="http://www.perl.com/CPAN/authors/id/S/SB/SBURKE/${P}.tar.gz"
HOMEPAGE="http://www.perl.com/CPAN/authors/id/S/SB/SBURKE/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha mips"
IUSE=""

mydoc="Changes MANIFEST README"
DEPEND=">=dev-perl/HTML-Tagset-3.03 >=dev-perl/HTML-Parser-2.19"
