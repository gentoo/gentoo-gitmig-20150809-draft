# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MogileFS-Utils/MogileFS-Utils-2.07.ebuild,v 1.2 2008/11/18 15:16:15 tove Exp $

inherit perl-module

DESCRIPTION="Server for the MogileFS distributed file system"
HOMEPAGE="http://search.cpan.org/search?query=MogileFS-Utils&mode=dist"
SRC_URI="mirror://cpan/authors/id/B/BR/BRADFITZ/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="virtual/perl-Compress-Zlib
		dev-perl/libwww-perl
		dev-perl/MogileFS-Client
		dev-lang/perl"
