# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/cache-mmap/cache-mmap-0.081.ebuild,v 1.1 2004/03/27 15:20:19 mcummings Exp $

inherit perl-module

MY_P=Cache-Mmap-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Shared data cache using memory mapped files"
SRC_URI="http://search.cpan.org/CPAN/authors/id/P/PM/PMH/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/PMH/${MY_P}"
SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86"
SRC_TEST="do"

DEPEND="dev-perl/Test-Simple
		dev-perl/Storable"
