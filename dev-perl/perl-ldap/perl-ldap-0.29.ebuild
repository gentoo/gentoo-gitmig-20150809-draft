# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-ldap/perl-ldap-0.29.ebuild,v 1.9 2005/04/01 18:10:16 blubb Exp $

inherit perl-module

DESCRIPTION="A collection of perl modules which provide an object-oriented interface to LDAP servers."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://perl-ldap.sourceforge.net"
IUSE="sasl xml ssl"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 alpha amd64 ~sparc ppc ia64 ~mips"

DEPEND="${DEPEND} dev-perl/Convert-ASN1
		dev-perl/URI
		sasl? ( dev-perl/Digest-MD5 dev-perl/Authen-SASL )
		xml? ( dev-perl/XML-Parser )
		ssl? ( >=dev-perl/IO-Socket-SSL-0.81 )"
