# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/cache-mmap/cache-mmap-0.081.ebuild,v 1.10 2005/06/15 17:51:08 gustavoz Exp $

inherit perl-module

MY_P=Cache-Mmap-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Shared data cache using memory mapped files"
SRC_URI="mirror://cpan/authors/id/P/PM/PMH/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/PMH/${MY_P}"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~ppc sparc"
IUSE=""
SRC_TEST="do"

DEPEND="perl-core/Test-Simple
		perl-core/Storable"
