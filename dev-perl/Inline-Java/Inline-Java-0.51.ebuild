# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Inline-Java/Inline-Java-0.51.ebuild,v 1.2 2006/07/04 11:36:38 ian Exp $

inherit perl-module

DESCRIPTION="Easy implimentaiton of Java extensions"
HOMEPAGE="http://search.cpan.org/~patl/${P}/"
SRC_URI="mirror://cpan/authors/id/P/PA/PATL/${P}.tar.gz"

LICENSE="Artistic"
#LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/Inline-0.44
		>=virtual/perl-Test-1.13
		>=virtual/jdk-1.4"
RDEPEND="${DEPEND}"

myconf="J2SDK=$JAVA_HOME"
mymake="java all"