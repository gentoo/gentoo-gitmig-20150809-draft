# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Statistics-Descriptive/Statistics-Descriptive-2.6.ebuild,v 1.3 2005/07/21 17:15:31 dholm Exp $

inherit perl-module

DESCRIPTION="Statistics-Descriptive module"
SRC_URI="mirror://cpan/authors/id/COLINK/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?module=Statistics::Descriptive"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""

SRC_TEST="do"
mydoc="README Changes UserSurvey.txt"

