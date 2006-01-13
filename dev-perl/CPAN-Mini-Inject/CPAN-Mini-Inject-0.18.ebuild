# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CPAN-Mini-Inject/CPAN-Mini-Inject-0.18.ebuild,v 1.2 2006/01/13 19:24:39 mcummings Exp $

inherit perl-module

DESCRIPTION="Inject modules into a CPAN::Mini mirror. "
HOMEPAGE="http://search.cpan.org/~ssoriche/${P}/"
SRC_URI="mirror://cpan/authors/id/S/SS/SSORICHE/${P}.tar.gz"

LICENSE="Artistic"
#LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="sparc x86"
IUSE=""

# Disabled 
#SRC_TEST="do"

DEPEND="dev-perl/libwww-perl
		dev-perl/Compress-Zlib
		dev-perl/HTTP-Server-Simple
		>=dev-perl/CPAN-Mini-0.32
		dev-perl/CPAN-Checksums"
