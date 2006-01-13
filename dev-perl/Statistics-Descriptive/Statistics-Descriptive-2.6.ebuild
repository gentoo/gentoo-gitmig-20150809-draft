# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Statistics-Descriptive/Statistics-Descriptive-2.6.ebuild,v 1.4 2006/01/13 22:20:23 mcummings Exp $

inherit perl-module

DESCRIPTION="Statistics-Descriptive module"
SRC_URI="mirror://cpan/authors/id/COLINK/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?module=Statistics::Descriptive"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~ppc sparc x86"
IUSE=""

SRC_TEST="do"
mydoc="README Changes UserSurvey.txt"

