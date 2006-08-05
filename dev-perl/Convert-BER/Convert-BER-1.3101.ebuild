# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Convert-BER/Convert-BER-1.3101.ebuild,v 1.13 2006/08/05 01:35:01 mcummings Exp $

inherit perl-module

DESCRIPTION="Class for encoding/decoding BER messages"
SRC_URI="mirror://cpan/authors/id/G/GB/GBARR/${P}.tar.gz"
HOMEPAGE="http://cpan.pair.com/modules/by-module/Convert/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""
DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
