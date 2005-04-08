# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SNMP/Net-SNMP-4.1.2.ebuild,v 1.7 2005/04/08 18:16:29 hansmi Exp $

inherit perl-module

DESCRIPTION="A SNMP Perl Module"
SRC_URI="http://www.cpan.org/modules/by-module/Net/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Net/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND="${DEPEND}
	>=dev-perl/libnet-1.0703
	dev-perl/Digest-MD5
	dev-perl/Digest-SHA1
	dev-perl/Digest-HMAC
	>=dev-perl/Crypt-DES-2.03"
