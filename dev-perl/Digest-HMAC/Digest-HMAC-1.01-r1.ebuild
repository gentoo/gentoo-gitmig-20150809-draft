# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-HMAC/Digest-HMAC-1.01-r1.ebuild,v 1.8 2004/02/15 22:13:05 esammer Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Keyed Hashing for Message Authentication"
SRC_URI="http://www.cpan.org/authors/id/GAAS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/doc/GAAS/${P}/README"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha hppa ~mips"

mydoc="rfc*.txt"

newdepend "dev-perl/digest-base dev-perl/Digest-MD5 dev-perl/Digest-SHA1"

src_compile() {
	perl-module_src_compile
	make test || die "Tests didn't work out. Aborting!"
}
