# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-HMAC/Digest-HMAC-1.01.ebuild,v 1.1 2002/06/11 10:19:26 seemant Exp $

# Inherit from perl-module.eclass
inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Keyed Hashing for Message Authentication"
SRC_URI="http://www.cpan.org/authors/id/GAAS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/doc/GAAS/${P}/README"

mydoc="rfc*.txt"

newdepend "dev-perl/Digest-MD5 dev-perl/Digest-SHA1"

src_compile() {
	base_src_compile
	make test || die "Tests didn't work out. Aborting!"
}
