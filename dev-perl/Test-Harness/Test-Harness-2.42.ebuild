# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Harness/Test-Harness-2.42.ebuild,v 1.3 2004/07/14 20:38:55 agriffis Exp $

inherit perl-module

DESCRIPTION="Runs perl standard test scripts with statistics"
SRC_URI="http://www.cpan.org/authors/id/P/PE/PETDANCE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?dist=Test-Harness"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
SRC_TEST="do"

DEPEND="dev-perl/Test-Pod
	|| ( dev-perl/File-Spec >=dev-lang/perl-5.8.0-r12 )"

mydoc="rfc*.txt"
