# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Telnet/Net-Telnet-3.03-r1.ebuild,v 1.6 2004/02/20 22:04:09 vapier Exp $

inherit perl-module

DESCRIPTION="A Telnet Perl Module"
HOMEPAGE="http://www.cpan.org/modules/by-module/Net/${P}.readme"
SRC_URI="http://www.cpan.org/modules/by-module/Net/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64"

DEPEND=">=dev-perl/libnet-1.0703"
