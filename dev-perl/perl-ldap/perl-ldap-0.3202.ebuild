# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-ldap/perl-ldap-0.3202.ebuild,v 1.2 2004/08/01 02:33:23 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="A collection of perl modules which provide an object-oriented interface to LDAP servers."
HOMEPAGE="http://search.cpan.org/~gbarr/${P}/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/G/GB/GBARR/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~ia64 ~s390 ~hppa"
IUSE="sasl xml ssl"

DEPEND="dev-perl/Convert-ASN1
	dev-perl/URI
	sasl? ( dev-perl/Digest-MD5 dev-perl/Authen-SASL )
	xml? ( dev-perl/XML-Parser )
	ssl? ( >=dev-perl/IO-Socket-SSL-0.81 )"

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
