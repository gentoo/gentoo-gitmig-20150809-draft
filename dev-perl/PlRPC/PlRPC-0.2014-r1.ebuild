# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PlRPC/PlRPC-0.2014-r1.ebuild,v 1.6 2002/08/01 04:05:43 cselkirk Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="The Perl RPC Module"
SRC_URI="http://www.cpan.org/modules/by-module/RPC/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/RPC/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc"

DEPEND="${DEPEND}
	>=dev-perl/Storable-1.0.7
	>=dev-perl/Net-Daemon-0.34"
