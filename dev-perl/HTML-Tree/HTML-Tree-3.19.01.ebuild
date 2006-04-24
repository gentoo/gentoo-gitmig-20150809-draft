# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Tree/HTML-Tree-3.19.01.ebuild,v 1.11 2006/04/24 15:33:01 flameeyes Exp $

inherit perl-module

MY_PV=${PV/.01/01}
MY_P=HTML-Tree-${MY_PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A library to manage HTML-Tree in PERL"
SRC_URI="mirror://cpan/authors/id/P/PE/PETDANCE/${MY_P}.tar.gz"
HOMEPAGE="http://seach.cpan.org/search?module=${MY_P}"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"

mydoc="Changes MANIFEST README"
DEPEND=">=dev-perl/HTML-Tagset-3.03
	>=dev-perl/HTML-Parser-2.19"
