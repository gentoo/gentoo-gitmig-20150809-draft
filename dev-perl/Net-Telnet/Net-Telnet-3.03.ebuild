# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Telnet/Net-Telnet-3.03.ebuild,v 1.1 2002/09/09 21:53:26 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A Telnet Perl Module"
SRC_URI="http://www.cpan.org/modules/by-module/Net/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Net/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc"

DEPEND="${DEPEND}
	>=dev-perl/libnet-1.0703"
