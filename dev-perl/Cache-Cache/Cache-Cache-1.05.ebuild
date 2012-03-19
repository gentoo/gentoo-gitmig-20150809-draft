# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cache-Cache/Cache-Cache-1.05.ebuild,v 1.13 2012/03/19 19:28:16 armin76 Exp $

inherit perl-module

DESCRIPTION="Generic cache interface and implementations"
SRC_URI="mirror://cpan/authors/id/D/DC/DCLINTON/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/D/DC/DCLINTON/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 hppa ppc ppc64 x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/Digest-SHA1-2.02
	>=dev-perl/Error-0.15
	>=virtual/perl-Storable-1.0.14
	>=dev-perl/IPC-ShareLite-0.09
	dev-lang/perl"

export OPTIMIZE="$CFLAGS"
