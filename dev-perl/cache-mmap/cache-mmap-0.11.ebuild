# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/cache-mmap/cache-mmap-0.11.ebuild,v 1.2 2008/09/05 17:15:10 armin76 Exp $

MODULE_AUTHOR=PMH
inherit perl-module

MY_P=Cache-Mmap-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Shared data cache using memory mapped files"
SRC_URI="mirror://cpan/authors/id/P/PM/PMH/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/dist/Cache-Mmap/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ia64 ~ppc sparc x86"
IUSE="test"

RDEPEND="virtual/perl-Storable
	dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Simple )"

SRC_TEST="do"
