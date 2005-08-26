# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-RSS/XML-RSS-1.05.ebuild,v 1.2 2005/08/26 00:41:58 agriffis Exp $

inherit perl-module

IUSE=""
DESCRIPTION="a basic framework for creating and maintaining RSS files"
SRC_URI="mirror://cpan/authors/id/K/KE/KELLAN/${P}.tar.gz"
HOMEPAGE="http://perl-rss.sourceforge.net/"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

SRC_TEST="do"

DEPEND="${DEPEND}
	dev-perl/Test-Manifest
		>=dev-perl/XML-Parser-2.30"
