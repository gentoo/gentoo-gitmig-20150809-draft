# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-MD4/Digest-MD4-1.5.ebuild,v 1.2 2005/08/15 10:11:19 mcummings Exp $

inherit perl-module

DESCRIPTION="MD4 message digest algorithm"
HOMEPAGE="http://search.cpan.org/authors/id/M/MI/MIKEM/DigestMD4/${P}.readme"
SRC_URI="mirror://cpan/authors/id/M/MI/MIKEM/DigestMD4/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~arm ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 sparc x86"
IUSE=""

SRC_TEST="do"
mydoc="README Changes"
