# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PlRPC/PlRPC-0.2014-r1.ebuild,v 1.4 2002/07/25 04:13:27 seemant Exp $


inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl RPC Module"
SRC_URI="http://www.cpan.org/modules/by-module/RPC/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.cpan.org/modules/by-module/RPC/${P}.readme"

SLOT="0"
DEPEND="${DEPEND}
	>=dev-perl/Storable-1.0.7
	>=dev-perl/Net-Daemon-0.34"
