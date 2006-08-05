# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Statistics-Descriptive/Statistics-Descriptive-2.6.ebuild,v 1.7 2006/08/05 20:40:32 mcummings Exp $

inherit perl-module

DESCRIPTION="Statistics-Descriptive module"
SRC_URI="mirror://cpan/authors/id/COLINK/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?module=Statistics::Descriptive"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"
mydoc="README Changes UserSurvey.txt"



DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
