# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-LDAP/Net-LDAP-0.29.ebuild,v 1.1 2003/08/14 02:25:30 robbat2 Exp $ 

inherit perl-module

MY_PN=perl-ldap
MY_P=${MY_PN}-${PV}
AUTHOR="GBARR"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A Perl LDAP interface"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/${AUTHOR:0:1}/${AUTHOR:0:2}/${AUTHOR}/"
SRC_URI="${HOMEPAGE}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86"

mydoc="CREDITS ChangeLog INSTALL MANIFEST OldChanges README RELEASE_NOTES SIGNATURE TODO"
DEPEND="${DEPEND}
	    dev-perl/Convert-ASN1
		dev-perl/URI
		sasl? ( dev-perl/Digest-MD5 dev-perl/Authen-SASL )
		ssl? ( dev-perl/IO-Socket-SSL )
		xml? ( dev-perl/XML-Parser )"
