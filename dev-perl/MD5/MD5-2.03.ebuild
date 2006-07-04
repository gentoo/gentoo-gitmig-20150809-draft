# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MD5/MD5-2.03.ebuild,v 1.12 2006/07/04 11:46:51 ian Exp $

inherit perl-module

DESCRIPTION="The Perl MD5 Module"
SRC_URI="mirror://cpan/authors/id/G/GA/GAAS/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/is/G/GA/GAAS/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND="virtual/perl-Digest-MD5"
RDEPEND="${DEPEND}"
SRC_TEST="do"

export OPTIMIZE="${CFLAGS}"