# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-ldap/perl-ldap-0.31.ebuild,v 1.3 2004/03/25 08:10:01 kumba Exp $

inherit perl-module

DESCRIPTION="A collection of perl modules which provide an object-oriented interface to LDAP servers."
SRC_URI="http://search.cpan.org/CPAN/authors/id/G/GB/GBARR/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~gbarr/${P}/"
IUSE="sasl xml ssl"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 alpha ~sparc ~ppc ia64 mips"

DEPEND="${DEPEND} dev-perl/Convert-ASN1
		dev-perl/URI
		sasl? ( dev-perl/Digest-MD5 dev-perl/Authen-SASL )
		xml? ( dev-perl/XML-Parser )
		ssl? ( >=dev-perl/IO-Socket-SSL-0.81 )"
