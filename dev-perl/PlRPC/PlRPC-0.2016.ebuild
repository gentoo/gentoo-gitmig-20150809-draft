# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PlRPC/PlRPC-0.2016.ebuild,v 1.8 2004/07/14 20:12:18 agriffis Exp $

inherit perl-module

DESCRIPTION="The Perl RPC Module"
SRC_URI="http://www.cpan.org/modules/by-module/RPC/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/RPC/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc alpha"
IUSE=""

DEPEND="${DEPEND}
	>=dev-perl/Storable-1.0.7
	>=dev-perl/Net-Daemon-0.34"
