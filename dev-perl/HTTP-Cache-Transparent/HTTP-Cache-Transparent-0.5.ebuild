# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-Cache-Transparent/HTTP-Cache-Transparent-0.5.ebuild,v 1.2 2005/04/25 21:26:49 mcummings Exp $

inherit perl-module

DESCRIPTION="Cache the result of http get-requests persistently."
HOMEPAGE="http://search.cpan.org/~mattiash/${P}"
SRC_URI="mirror://cpan/authors/id/M/MA/MATTIASH/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/libwww-perl
	dev-perl/Digest-MD5
	dev-perl/Storable"
