# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-ldap/perl-ldap-0.33-r1.ebuild,v 1.16 2006/10/20 20:26:09 kloeri Exp $

inherit perl-module

DESCRIPTION="A collection of perl modules which provide an object-oriented interface to LDAP servers."
HOMEPAGE="http://search.cpan.org/~gbarr/${P}/"
SRC_URI="mirror://cpan/authors/id/G/GB/GBARR/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
#KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="sasl xml ssl"

DEPEND="dev-perl/Convert-ASN1
	dev-perl/URI
	sasl? ( virtual/perl-Digest-MD5 dev-perl/Authen-SASL )
	xml? ( dev-perl/XML-Parser
			dev-perl/XML-SAX
			dev-perl/XML-SAX-Writer )
	ssl? ( >=dev-perl/IO-Socket-SSL-0.81 )
	dev-lang/perl"
RDEPEND="${DEPEND}"

src_compile() {
	if [ "${MMSIXELEVEN}" ]; then
		echo 'n' | perl Makefile.PL ${myconf} \
		PREFIX=/usr INSTALLDIRS=vendor DESTDIR=${D}
	else
		echo 'n' | perl Makefile.PL ${myconf} \
		PREFIX=${D}/usr INSTALLDIRS=vendor
	fi
	perl-module_src_test
}

