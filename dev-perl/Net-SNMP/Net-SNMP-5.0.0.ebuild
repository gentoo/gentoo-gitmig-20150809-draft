# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SNMP/Net-SNMP-5.0.0.ebuild,v 1.10 2006/07/04 13:45:06 ian Exp $

inherit perl-module

DESCRIPTION="A SNMP Perl Module"
SRC_URI="mirror://cpan/modules/by-module/Net/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Net/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND=">=virtual/perl-libnet-1.0703
	virtual/perl-Digest-MD5
	dev-perl/Digest-SHA1
	dev-perl/Digest-HMAC
	>=dev-perl/Crypt-DES-2.03"
RDEPEND="${DEPEND}"