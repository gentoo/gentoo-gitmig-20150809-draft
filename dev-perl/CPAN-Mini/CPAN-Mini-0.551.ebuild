# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CPAN-Mini/CPAN-Mini-0.551.ebuild,v 1.4 2007/01/22 04:10:52 kloeri Exp $

inherit perl-module

DESCRIPTION="create a minimal mirror of CPAN"
HOMEPAGE="http://search.cpan.org/~rjbs/${P}/"
SRC_URI="mirror://cpan/authors/id/R/RJ/RJBS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/libwww-perl
		>=dev-perl/Compress-Zlib-1.20
		dev-perl/File-HomeDir
		dev-perl/URI
	dev-lang/perl"
