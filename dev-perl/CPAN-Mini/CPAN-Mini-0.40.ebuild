# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CPAN-Mini/CPAN-Mini-0.40.ebuild,v 1.1 2005/11/22 13:44:59 mcummings Exp $

inherit perl-module

DESCRIPTION="create a minimal mirror of CPAN"
HOMEPAGE="http://search.cpan.org/~rjbs/${P}/"
SRC_URI="mirror://cpan/authors/id/R/RJ/RJBS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/libwww-perl
		>=dev-perl/Compress-Zlib-1.20
		dev-perl/File-HomeDir
		dev-perl/URI"
