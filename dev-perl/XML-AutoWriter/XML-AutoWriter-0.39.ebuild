# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-AutoWriter/XML-AutoWriter-0.39.ebuild,v 1.4 2006/07/05 13:10:40 ian Exp $

inherit perl-module

DESCRIPTION="DOCTYPE based XML output"
SRC_URI="mirror://cpan/authors/id/R/RB/RBS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rbs/${P}/"
IUSE=""
SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~hppa ~ia64 sparc ~x86"

DEPEND="dev-perl/XML-Parser"
RDEPEND="${DEPEND}"

SRC_TEST="do"