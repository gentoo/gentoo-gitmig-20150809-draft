# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Digest/IO-Digest-0.10.ebuild,v 1.7 2005/06/15 17:41:37 gustavoz Exp $

inherit perl-module

DESCRIPTION="IO::Digest - Calculate digests while reading or writing"
SRC_URI="mirror://cpan/authors/id/C/CL/CLKAO/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/IO/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~amd64 ~ppc sparc"
SRC_TEST="do"
IUSE=""
DEPEND="${DEPEND}
	>=dev-perl/PerlIO-via-dynamic-0.10
	perl-core/digest-base"
