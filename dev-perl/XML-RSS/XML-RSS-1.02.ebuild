# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-RSS/XML-RSS-1.02.ebuild,v 1.1 2003/10/03 12:10:06 mcummings Exp $

inherit perl-module

IUSE=""
DESCRIPTION="a basic framework for creating and maintaining RSS files"
SRC_URI="http://www.cpan.org/modules/by-module/XML/${P}.tar.gz"
HOMEPAGE="http://perl-rss.sourceforge.net/"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~sparc"

DEPEND="${DEPEND}
	dev-perl/Test-Manifest
		>=dev-perl/XML-Parser-2.30"
