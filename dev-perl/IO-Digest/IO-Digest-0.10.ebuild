# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Digest/IO-Digest-0.10.ebuild,v 1.2 2005/02/05 14:24:37 absinthe Exp $

inherit perl-module

DESCRIPTION="IO::Digest - Calculate digests while reading or writing"
SRC_URI="http://www.cpan.org/modules/by-module/IO/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/IO/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64"
SRC_TEST="do"
IUSE=""
DEPEND="${DEPEND}
	>=dev-perl/PerlIO-via-dynamic-0.10
	dev-perl/digest-base"
