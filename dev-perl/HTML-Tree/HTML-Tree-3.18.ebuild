# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Maintainer: José Alberto Suárez López <bass@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Tree/HTML-Tree-3.18.ebuild,v 1.3 2004/07/14 17:54:57 agriffis Exp $

inherit perl-module

MY_P=HTML-Tree-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A library to manage HTML-Tree in PERL"
SRC_URI="http://www.perl.com/CPAN/authors/id/S/SB/SBURKE/${P}.tar.gz"
HOMEPAGE="http://www.perl.com/CPAN/authors/id/S/SB/SBURKE/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
IUSE=""

SRC_TEST="do"

mydoc="Changes MANIFEST README"
DEPEND=">=dev-perl/HTML-Tagset-3.03
	>=dev-perl/HTML-Parser-2.19"
