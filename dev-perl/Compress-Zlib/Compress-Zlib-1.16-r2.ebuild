# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Compress-Zlib/Compress-Zlib-1.16-r2.ebuild,v 1.10 2005/01/04 12:05:37 mcummings Exp $

inherit perl-module

DESCRIPTION="A Zlib perl module"
SRC_URI="mirror://cpan/authors/id/P/PM/PMQS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~pmqs/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND="${DEPEND}
	>=sys-libs/zlib-1.1.3"

mydoc="TODO"
