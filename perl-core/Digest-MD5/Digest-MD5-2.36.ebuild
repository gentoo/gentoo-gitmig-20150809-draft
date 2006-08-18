# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Digest-MD5/Digest-MD5-2.36.ebuild,v 1.8 2006/08/18 02:17:54 mcummings Exp $

inherit perl-module

DESCRIPTION="MD5 message digest algorithm"
HOMEPAGE="http://search.cpan.org/~gaas/${P}/"
SRC_URI="mirror://cpan/authors/id/G/GA/GAAS/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ~hppa ia64 ~mips ~ppc ~ppc64 ~s390 sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl
		virtual/perl-digest-base"
RDEPEND="${DEPEND}"

mydoc="rfc*.txt"
