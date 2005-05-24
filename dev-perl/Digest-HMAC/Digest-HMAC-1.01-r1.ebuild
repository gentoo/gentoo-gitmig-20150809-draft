# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-HMAC/Digest-HMAC-1.01-r1.ebuild,v 1.18 2005/05/24 14:57:29 mcummings Exp $

inherit perl-module

DESCRIPTION="Keyed Hashing for Message Authentication"
HOMEPAGE="http://search.cpan.org/doc/GAAS/${P}/README"
SRC_URI="mirror://cpan/authors/id/GAAS/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE=""

SRC_TEST="do"

mydoc="rfc*.txt"

DEPEND="perl-core/digest-base
	dev-perl/Digest-MD5
	dev-perl/Digest-SHA1"
