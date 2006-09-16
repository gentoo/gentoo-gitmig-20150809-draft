# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Tail/File-Tail-0.99.3.ebuild,v 1.8 2006/09/16 20:59:53 dertobi123 Exp $

inherit perl-module

DESCRIPTION="Perl extension for reading from continously updated files"
SRC_URI="mirror://cpan/authors/id/M/MG/MGRABNAR/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/MGRABNAR/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc ~x86"
IUSE=""

DEPEND="virtual/perl-Time-HiRes
	dev-lang/perl"
RDEPEND="${DEPEND}"

export OPTIMIZE="$CFLAGS"
mydoc="ToDo"

