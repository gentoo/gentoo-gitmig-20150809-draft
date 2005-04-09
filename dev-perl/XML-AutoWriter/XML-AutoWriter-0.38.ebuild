# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-AutoWriter/XML-AutoWriter-0.38.ebuild,v 1.1 2005/04/09 00:44:27 trapni Exp $

inherit perl-module

DESCRIPTION="XML-AutoWriter"
SRC_URI="mirror://cpan/authors/id/R/RB/RBS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rbs/${P}/"
IUSE=""
SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~amd64"

DEPEND="dev-perl/XML-Parser"

SRC_TEST="do"
