# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-HMAC/Digest-HMAC-1.01-r1.ebuild,v 1.16 2005/01/22 06:25:11 vapier Exp $

inherit perl-module

DESCRIPTION="Keyed Hashing for Message Authentication"
HOMEPAGE="http://search.cpan.org/doc/GAAS/${P}/README"
SRC_URI="http://www.cpan.org/authors/id/GAAS/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE=""

mydoc="rfc*.txt"

DEPEND="dev-perl/digest-base
	dev-perl/Digest-MD5
	dev-perl/Digest-SHA1"

src_compile() {
	perl-module_src_compile
	make test || die "Tests didn't work out. Aborting!"
}
