# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SNMP/Net-SNMP-4.1.0.ebuild,v 1.1 2003/06/16 14:11:06 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A SNMP Perl Module"
SRC_URI="http://www.cpan.org/modules/by-module/Net/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Net/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="${DEPEND}
	>=dev-perl/libnet-1.0703 \
	>=dev-perl/Crypt-DES-2.03"
