# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SNMP/Net-SNMP-5.2.0.ebuild,v 1.16 2008/05/13 13:57:46 jer Exp $

inherit perl-module

DESCRIPTION="A SNMP Perl Module"
SRC_URI="mirror://cpan/authors/id/D/DT/DTOWN/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Net/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=virtual/perl-libnet-1.0703
	>=virtual/perl-Digest-MD5-2.11
	>=dev-perl/Digest-SHA1-1.02
	>=dev-perl/Digest-HMAC-1.0
	>=dev-perl/Crypt-DES-2.03
	dev-lang/perl"
