# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-DNS/Net-DNS-0.38.ebuild,v 1.4 2004/01/09 22:07:30 gustavoz Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl Net::DNS - Perl DNS Resolver Module"
SRC_URI="http://www.net-dns.org/download/${P}.tar.gz"
HOMEPAGE="http://www.fuhr.org/~mfuhr/perldns/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~amd64 ~ppc sparc ~alpha hppa"

newdepend "dev-perl/Digest-MD5 dev-perl/Digest-HMAC dev-perl/MIME-Base64 || ( dev-perl/Test-Simple >=perl-5.8.0-r12 )"
mydoc="TODO"

src_compile() {

	echo "n" | perl-module_src_compile
	perl-module_src_test
}

