# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Statistics-Descriptive/Statistics-Descriptive-2.6.ebuild,v 1.12 2007/07/10 23:33:28 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="Statistics-Descriptive module"
SRC_URI="mirror://cpan/authors/id/COLINK/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?module=Statistics::Descriptive"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"
mydoc="README UserSurvey.txt"

DEPEND="dev-lang/perl"
