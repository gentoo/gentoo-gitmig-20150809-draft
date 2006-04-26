# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-RSS/XML-RSS-1.10.ebuild,v 1.1 2006/04/26 00:12:30 mcummings Exp $

inherit perl-module

IUSE=""
DESCRIPTION="a basic framework for creating and maintaining RSS files"
SRC_URI="mirror://cpan/authors/id/A/AB/ABH/${P}.tar.gz"
HOMEPAGE="http://perl-rss.sourceforge.net/"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

SRC_TEST="do"

DEPEND="${DEPEND}
		>=dev-perl/Test-Manifest-0.9
		>=dev-perl/XML-Parser-2.30"
