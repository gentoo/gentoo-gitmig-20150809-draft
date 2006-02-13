# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/OpenCA-REQ/OpenCA-REQ-0.9.52.ebuild,v 1.12 2006/02/13 13:46:19 mcummings Exp $

inherit perl-module
DESCRIPTION="The perl OpenCA::REQ Module"
SRC_URI="mirror://cpan/authors/id/M/MA/MADWOLF/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/M/MA/MADWOLF/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

SRC_TEST="do"

export OPTIMIZE="${CFLAGS}"

DEPEND="dev-perl/X500-DN
	virtual/perl-Digest-MD5"
