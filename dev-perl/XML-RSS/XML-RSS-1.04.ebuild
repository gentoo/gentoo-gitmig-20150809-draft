# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-RSS/XML-RSS-1.04.ebuild,v 1.5 2005/02/18 17:28:57 luckyduck Exp $

inherit perl-module

IUSE=""
DESCRIPTION="a basic framework for creating and maintaining RSS files"
SRC_URI="http://www.cpan.org/modules/by-module/XML/${P}.tar.gz"
HOMEPAGE="http://perl-rss.sourceforge.net/"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ~x86 ~sparc ~alpha ppc"

DEPEND="${DEPEND}
	dev-perl/Test-Manifest
		>=dev-perl/XML-Parser-2.30"
