# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/OpenCA-REQ/OpenCA-REQ-0.9.52.ebuild,v 1.15 2006/12/11 11:48:52 yuval Exp $

inherit perl-module
DESCRIPTION="The perl OpenCA::REQ Module"
SRC_URI="mirror://cpan/authors/id/M/MA/MADWOLF/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~madwolf/${P}/REQ.pm"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

SRC_TEST="do"

export OPTIMIZE="${CFLAGS}"

DEPEND="dev-perl/X500-DN
	virtual/perl-Digest-MD5
	dev-lang/perl"
RDEPEND="${DEPEND}"

