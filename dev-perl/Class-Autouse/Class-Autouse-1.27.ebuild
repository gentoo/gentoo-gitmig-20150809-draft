# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Autouse/Class-Autouse-1.27.ebuild,v 1.6 2006/10/21 11:04:09 dertobi123 Exp $

inherit perl-module
DESCRIPTION="Runtime aspect loading of one or more classes"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~adamk/${P}"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~hppa ia64 ppc sparc ~x86"
DEPEND="virtual/perl-Test-Simple
		dev-perl/ExtUtils-AutoInstall
		>=virtual/perl-Scalar-List-Utils-1.18
	dev-lang/perl"

SRC_TEST="do"
