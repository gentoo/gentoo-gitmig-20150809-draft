# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-DNS/Net-DNS-0.37.ebuild,v 1.1 2003/06/16 13:54:34 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl Net::DNS - Perl DNS Resolver Module"
SRC_URI="http://www.net-dns.org/download/${P}.tar.gz"
HOMEPAGE="http://www.fuhr.org/~mfuhr/perldns/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

newdepend "dev-perl/Digest-MD5 dev-perl/Digest-HMAC dev-perl/MIME-Base64 dev-perl/Test-Simple"
mydoc="TODO"

src_compile() {

	echo "n" | perl-module_src_compile 
	perl-module_src_test
}

